namespace :scan do
  desc "scan all attached documents for malware"
  task documents: [:environment] do
    infected_count = 0
    messages = []
    Intake.all.each do |i|
      i.documents.each do |d|
        print '.'
        unless d.safe?
          messages << "<intake ##{i.id}/doc ##{d.id}[#{d.document_type}]> failed the malware scan."
          infected_count += 1
        end
      end
    end
    puts messages.join("\n")
    puts "found #{infected_count} infected files"
  end
end