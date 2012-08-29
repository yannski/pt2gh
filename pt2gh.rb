require "rubygems"
require "bundler/setup"

require "octokit"
require "csv"

client = Octokit::Client.new(:login => "yannski", :password => "nosvat")

require "pp"
pp "$$$$$$$$$$$$$"

repo = "novelys/homespa"

milestones = {}
milestone = nil

CSV.foreach("sample.csv", :col_sep => ",", :headers => true, :skip_blanks => true) do |row|
  title = row[1]
  milestone_name = row[3]
  type = row[6]
  body = row[14]
  pt_url = row[15]
  comments = []
  1.upto(13) do |i|
    str = row[15+i]
    comments << str if str && str != ""
  end

  #if milestones[milestone_name].nil? && (!milestone_name.nil? && milestone_name != "")
  #  milestone = client.create_milestone(repo, milestone_name)
  # milestones[milestone_name] = milestone["number"]
  #end
  
  #issue = client.create_issue(repo, title, body, {"milestone" => milestones[milestone_name]})
  issue = client.create_issue(repo, title, body)

  client.add_comment(repo, issue["number"], pt_url)

  if comments.any?
    comments.each{|comment|
      client.add_comment(repo, issue["number"], comment)
    }
  end
end