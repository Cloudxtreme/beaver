require 'sinatra/activerecord'
require 'open-uri'
require 'fileutils'
class OperatingSystem < ActiveRecord::Base
  validates :name, presence: true
  validates :url, presence: true
  validates :major, presence: true
  validates :minor, presence: true

after_save :get_kernel_and_initrd

private
  def get_kernel_and_initrd
    label = "#{self.name.gsub(' ','_')}_#{self.major.to_s}_#{self.minor.to_s}"
    FileUtils.mkdir_p "/var/lib/tftpboot/#{label}/" unless File.exists?("/var/lib/tftpboot/#{label}/")
    %W(vmlinuz initrd.img).each do |data|
      begin
        download = open(self.url + "/images/pxeboot/#{data}")
        IO.copy_stream(download, "/var/lib/tftpboot/#{label}/#{data}") unless File.exists?("/var/lib/tftpboot/#{label}/#{data}")
      rescue
        next
      end
    end
  end
end
