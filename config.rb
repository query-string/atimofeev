# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml',  layout: false
page '/*.json', layout: false
page '/*.txt',  layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

set :host, ENV['SITE_URL']

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

helpers do
  def entries(name)
    @app.data['query-string'].send(name).map { |m| m[1] }
  end

  %i(cards projects technologies).each do |name|
    define_method(name) do
      entries(name)
    end
  end

  def card
    cards.first
  end

  def works
    entries('works').sort_by(&:started).reverse
  end
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

# configure :build do
#   activate :minify_css
#   activate :minify_javascript
# end

activate :i18n

activate :contentful do |f|
  f.cda_query     = { limit: 1000 }
  f.all_entries   = true
  f.space         = { 'query-string' => ENV['CONTENTFUL_SPACE_ID'] }
  f.access_token  = ENV['CONTENTFUL_ACCESS_TOKEN']
  f.content_types = { cards: 'cards', works: 'works', projects: 'projects', technologies: 'technologies' }
end

activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = ENV['AWS_BUCKET']
  s3_sync.region                     = ENV['AWS_REGION']
  s3_sync.aws_access_key_id          = ENV['AWS_KEY']
  s3_sync.aws_secret_access_key      = ENV['AWS_SECRET']
  s3_sync.delete                     = false # We delete stray files by default.
  s3_sync.after_build                = false # We do not chain after the build step by default.
  s3_sync.prefer_gzip                = true
  s3_sync.path_style                 = true
  s3_sync.reduced_redundancy_storage = false
  s3_sync.acl                        = 'public-read'
  s3_sync.encryption                 = false
  s3_sync.prefix                     = ''
  s3_sync.version_bucket             = false
  s3_sync.index_document             = 'index.html'
  s3_sync.error_document             = '404.html'
end

activate :cloudfront do |cf|
  cf.access_key_id     = ENV['AWS_KEY']
  cf.secret_access_key = ENV['AWS_SECRET']
  cf.distribution_id   = ENV['CF_DISTRIBUTION']
  cf.filter = /\.html$/i
end
