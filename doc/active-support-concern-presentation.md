# ActiveSupport::Concern

## TL;DR:

1. Recognize existing or potential repeated code across classes
2. Move to a well named module in a concerns folder
3. add `extend ActiveSupport::Concern`
4. move instance methods anywhere in the module (this is how view helpers
already work)
5. move any class methods into class_methods block (or ClassMethods class)
6. move any class method calls (e.g. `has_many books`) into the included block
7. include your module in any class that requires the method calls and some or
all of the class or instance methods.

## An example from our code:

```ruby
module FormAttributes
  extend ActiveSupport::Concern

  included do
    extend AutoStripAttributes
    class_attribute :attribute_names
  end

  class_methods do
    def set_attributes_for(model, *attributes)
      scoped_attributes[model] = attributes
      self.attribute_names = scoped_attributes.values.flatten
      attribute_strings = Attributes.new(attributes).to_s

      attr_accessor(*attribute_strings)
      auto_strip_attributes *attribute_strings, virtual: true
    end

    def scoped_attributes
      @scoped_attributes ||= {}
    end

    def existing_attributes(model)
      if model.present?
        HashWithIndifferentAccess.new(model.attributes)
      else
        {}
      end
    end
  end

  def attributes_for(model)
    self.class.scoped_attributes[model].reduce({}) do |hash, attribute_name|
      hash[attribute_name] = send(attribute_name)
      hash
    end
  end
```

[commit showing extraction to
concern](https://github.com/codeforamerica/vita-min/commit/24e14f39caac2e8a31a73ef73b3be8f490999745#diff-b5a025c52f6beb69f9d8aab897ff7b02)

## A bit of history

Extracting shared code to an included module has been a well known pattern in
Ruby since its early adoption. Most of what ActiveSupport::Concern provides can
be done with native Ruby using the `self.included` hook [available to all modules
from Module](https://apidock.com/ruby/Module/included)

ActiveSupport::Concern added some syntactical sugar as explained
[here](https://api.rubyonrails.org/classes/ActiveSupport/Concern.html). It also
"gracefully handles module dependencies" something that with our simple projects
we are less concerned.

I (Jonathan Greenberg) remember attending a late night talk given by Yehuda Katz
at Rails conf talking about these meta-programming details of Ruby and how they
were incorporated into Rails. This was an exciting time for Rails as it was
announcing the great merging of Merb into Rails 3.0. I think I understood less
than a fraction of what he shared and my mind was blown.

## Diving A Bit Deeper

Part of the beauty or Ruby (and Rails) is that you don't really need to understand
features like ActiveSupport::Concern and the meta-programming magic they perform.
However, if you are curious, it is not an impossible feat to peel back the veil
a bit.

If you are interested in understanding some of this in greater depth I highly
recommend reading (and rereading) some books and/or blog posts on Ruby Metaprogramming.
There are also great videos. I just watched again [a video by Dave
Thomas](https://www.infoq.com/presentations/metaprogramming-ruby/) I first watched
probably a decade ago. While the video quality was perhaps not as good back
then it is amazing how little the quality and relevance of the material has not
changed over time.

Looking at the [source code](https://raw.githubusercontent.com/rails/rails/master/activesupport/lib/active_support/concern.rb):

```ruby
module Concern
  class MultipleIncludedBlocks < StandardError #:nodoc:
    def initialize
      super "Cannot define multiple 'included' blocks for a Concern"
    end
  end

  class MultiplePrependBlocks < StandardError #:nodoc:
    def initialize
      super "Cannot define multiple 'prepended' blocks for a Concern"
    end
  end
```

A few error classes; a familiar pattern here at least...

```ruby
  def self.extended(base) #:nodoc:
    base.instance_variable_set(:@_dependencies, [])
  end
```

The first of some hooks that presumably address the dependency resolution mentioned
above. Just from the name `self.extended` you can guess that this action is called whenever
ActiveSupport::Concern is extending a class and allows the module to add an
instance variable on the `base` class. We would probably need to dig deeper into Ruby
to understand some of this code.

```ruby
  def append_features(base) #:nodoc:
    if base.instance_variable_defined?(:@_dependencies)
      base.instance_variable_get(:@_dependencies) << self
      false
    else
      return false if base < self
      @_dependencies.each { |dep| base.include(dep) }
      super
      base.extend const_get(:ClassMethods) if const_defined?(:ClassMethods)
      base.class_eval(&@_included_block) if instance_variable_defined?(:@_included_block)
    end
  end

  def prepend_features(base) #:nodoc:
    if base.instance_variable_defined?(:@_dependencies)
      base.instance_variable_get(:@_dependencies).unshift self
      false
    else
      return false if base < self
      @_dependencies.each { |dep| base.prepend(dep) }
      super
      base.singleton_class.prepend const_get(:ClassMethods) if const_defined?(:ClassMethods)
      base.class_eval(&@_prepended_block) if instance_variable_defined?(:@_prepended_block)
    end
  end
```

`append_features` and `prepend_features` are lesser used hooks. The `base <
self` is an interesting little feature that you don't see or use often that
does a check for inheritance. Ignoring the dependencies stuff the more relevant
piece for us is:

``` ruby
  base.extend const_get(:ClassMethods) if const_defined?(:ClassMethods)
  base.class_eval(&@_included_block) if instance_variable_defined?(:@_included_block)
```

That is where the some of the syntactical sugar comes in that does the extending
of class methods for us and the class evaluation of the included block. And the
following is where the `@included_block` variable gets set:

```ruby
  def included(base = nil, &block)
    if base.nil?
      if instance_variable_defined?(:@_included_block)
        if @_included_block.source_location != block.source_location
          raise MultipleIncludedBlocks
        end
      else
        @_included_block = block
      end
    else
      super
    end
  end
```

Prepending is a more recent feature of Ruby. Less used but has its special use
cases ActiveSupport::Concern supports it along with included:

``` ruby
  def prepended(base = nil, &block)
    if base.nil?
      if instance_variable_defined?(:@_prepended_block)
        if @_prepended_block.source_location != block.source_location
          raise MultiplePrependBlocks
        end
      else
        @_prepended_block = block
      end
    else
      super
    end
  end
```

And finally here is the simple syntactical sugar transfering the `class_methods`
to a ClassMethods module which was the original default implementation for
grouping and auto including class methods when including the concern module:

```ruby
  def class_methods(&class_methods_module_definition)
    mod = const_defined?(:ClassMethods, false) ?
      const_get(:ClassMethods) :
      const_set(:ClassMethods, Module.new)

    mod.module_eval(&class_methods_module_definition)
  end
end
```

And if that was not enough you can [check out
Module#concerning](https://api.rubyonrails.org/classes/Module/Concerning.html)
a bit more syntactical sugar that ActiveSupport injects into Module that
builds on ActiveSupport::Concern to help organize code within a class. I
actually was not aware of this and have not used or seen it used ... so far.
