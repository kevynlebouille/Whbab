Wisepdf::Configuration.configure do |config|
  config.wkhtmltopdf = "#{Rails.root}/script/wkhtmltopdf"
  config.options = {
    :layout => "pdf.html",
    :show_as_html => Rails.env.development?,
  }
end
