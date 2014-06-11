require 'spec_helper_acceptance'

describe 'integration', :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  context 'running standard install' do
    it 'should run with no errors' do
      pp = <<-EOS
      class { '::site::roles::base': }
      class { '::site::roles::webserver': }
      class { '::site::roles::website': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe service('nginx') do
      it {
        should be_enabled
      }
      it {
        should be_running
      }
    end

    describe port(8000) do
      it { should be_listening.with('tcp') }
    end

    describe command('curl localhost:8000 | grep "Basic webpage for PSE Exercise"') do
      it { should return_exit_status 0 }
    end
  end
end
