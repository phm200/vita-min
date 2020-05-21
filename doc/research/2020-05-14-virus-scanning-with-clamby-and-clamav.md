# Research: Malware Scanning (clamav / clamby)

Related Story: [PT#172783188](https://www.pivotaltracker.com/story/show/172783188)

Related Commit:
[a3ead500...](https://github.com/codeforamerica/vita-min/commit/a3ead500b93ce2f72192422af9e25efd49c8e1b2)

## Context

In order to facilitate client returns, VITA volunteers download documents clients
have submitted. We would like to ensure that those volunteers are downloading
files that have been through a virus scanning process.

## Threat Surface

This research is limited to uploading client documents. The threat surface here
includes a series of pages for uploading various documents, but these are
consolidated in the `Document` model. The document attachments are stored (as
`:upload`) using the
[ActiveStorage](https://edgeguides.rubyonrails.org/active_storage_overview.html) mechanism.

The files uploaded by the clients are potential threats.

## Remediation

### Scanning Service (e.g., `clamd`)

In order to detect that a file includes some form of malware, the tools must be
available. It's best to run a service to make the scanning process as quick as
possible. This will involve updating the deployment environment to install the
scanning daemon, and configuring the service to run.

It's also necessary to regularly update the malware signature database. This
should be done on deploy and regularly as a part of the normal operation of the
environment. With ClamAV, this is accomplished via running the `freshclam`
service.

### Scanning Attached Files

It's possible to scan attached files at any of the lifecycle events for storing
an attachment. Once detected, a decision has to be made as to how the infected
files are disposed of. (See referenced commit for a proof of concept.)

Any scanning software may be used, however `clamav` is a straightforward, free
option with a well-understood method of integration, and a supporting ruby gem
(albeit, a 3rd party gem). It also runs well on both linux and mac systems,
facilitating development.

### Infected File Handling

Using the Principle of Least Surprise, we want to ensure that if we've disposed
of a file (whether via quarantine or deletion), we mark the Document record such
that we can know that there was an attachment, and it was disposed of due to the
presence of a malware signature.

Given the staffing level of this project, we should choose a path that does not
overburden the existing staff. Recommend immediate deletion.

Another question is how to notify the clients and partners. Recommend not
notifying the clients at all (fail silently), but notifying the partner handling
the client that the files were attached but were deleted due to malware. They
can then follow up with direct contact to the client.

## Consequences

When moving in this direction, developers will need to install the chosen
scanner on their development boxes, which means setup documentation will need to
be written to that effect.

The deployment environments will also need to be configured appropriately.

Testing that a detected file has been appropriately disposed of should be a part
of the regular automated test suite (see the commit for an example of how to do
this).

Decisions will need to be made (and design work done) around the follow-up
questions in the next section.

## Follow-Up Questions

1. When should uploads be scanned? 
  * prior to save
  * after save
  * live vs background job
  * prior to attachment to a Zendesk ticket
2. What should be done with the infected file?
  * flag and delete automatically
  * flag and quarantine
  * flag and wait for manual process
3. What does the client workflow look like?
  * notify the user they have an infection
  * accept silently and flag (odds are good they don't
    know they have a problem)
4. What does the partner workflow look like?
  * say nothing, only missing document
  * notify the partner that a document was submitted but that it was infected

