if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['AKIAIPNECCZSCXJM33BQ'],
      :aws_secret_access_key => ENV['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']
    }
    config.fog_directory     =  ENV['classmaster1']
  end
end