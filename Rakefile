desc "Publish to S3"
task :publish do
  sh "kill -9 `ps auxw|grep gulp|grep -v grep|awk '{print $2}'`"
  sh "bundle exec jekyll build"
  sh "bundle exec s3_website push"
end

