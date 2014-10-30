desc "Publish to S3"
task :publish do
  sh "bundle exec jekyll build"
  sh "bundle exec s3_website push"
end

