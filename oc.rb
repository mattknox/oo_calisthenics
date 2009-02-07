require "oocalisthenics.rb"
t = Timestamp.new
t.set_updated_at!
b = Body.new("body")
t = Title.new("title")



require "oonatural.rb"
u = User.new("matt", "email")
u.create_blog("blogname")
blog = u.bloglist[0]
u.post(blog, "posttitle", "postbody")
p = u.bloglist[0].postlist[0]
u.comment(p, "commenttitle", "commentbody")


require "oocalisthenics.rb"
u = User.new("matt", "email")
u.create_blog("blogname")
blog = u.bloglist[0]
u.post(blog, "posttitle", "postbody")
p = u.bloglist[0].postlist[0]
u.comment(p, "commenttitle", "commentbody")
