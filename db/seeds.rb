# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(email: 'blank@thoughtworks.com', password: 'helloworld', password_confirmation: 'helloworld')

xli = User.create!(email: 'swing1979@gmail.com', password: 'helloworld', password_confirmation: 'helloworld')
xli.continuous_deployments.create(name: 'DTR next release',
                                  deployed_revision_url: 'http://rubygems.org/gems/dtr',
                                  deployed_revision_extract_regex: 'dtr\s*(\d.\d.\d)\s',
                                  git_repo_url: 'https://github.com/xli/dtr.git')
