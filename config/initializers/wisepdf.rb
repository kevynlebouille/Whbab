Wisepdf::Configuration.configure do |config|
  config.wkhtmltopdf = "#{Rails.root}/script/wkhtmltopdf"
  config.options = {
    :encoding => 'utf8',
    :layout => "pdf.html",
    # :show_as_html => true,
  }
end