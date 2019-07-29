class AiBackupsListingController < ApplicationController

  def index
    @filenames = collect_file_names
  end

  private

  def collect_file_names
    filenames = []
    Dir.foreach("#{Rails.root}/public/ai_backups") do |item|
      next if item == '.' or item == '..'
      filenames << item
    end
    filenames
  end
end