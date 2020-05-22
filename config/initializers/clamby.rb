config_file = (Rails.env.development? || Rails.env.test?) ? nil : Rails.root.join("etc/clamav/clamd.conf")

Clamby.configure({
  check: true,
  daemonize: true,
  config_file: config_file,
  error_clamscan_missing: true,
  error_clamscan_client_error: true,
  error_file_missing: false,
  error_file_virus: false,
  fdpass: false,
  output_level: 'off',
  stream: true,
  executable_path_clamscan: 'clamscan',
  executable_path_clamdscan: 'clamdscan',
  executable_path_freshclam: 'freshclam',
})
