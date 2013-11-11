desc "Preview mode, include drafts"
task :preview do
  sh "bundle exec jekyll build --watch --drafts"
end

desc "Publish to S3"
task :publish do
  sh "bundle exec jekyll build"
  sh "bundle exec s3_website push"
end
