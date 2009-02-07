# actual models: user blog post comment
class Timestamp
  attr_reader :updated_at, :created_at
  def initialize
    now = DateTime.now
    @created_at = now
    @updated_at = now
  end

  def update!
    @updated_at = DateTime.now
  end
end

class User 
  attr_accessor :name, :email, :bloglist, :commentlist
  def initialize(name, email)
    @name = name
    @email = email
    @bloglist = []
    @commentlist = []
    @timestamp = Timestamp.new
  end

  def create_blog(title)
    @bloglist << Blog.new(self, title)
  end

  def post(blog, title, body)
    blog.accept_post(Post.new(blog, title, body))
  end

  def comment(post, title, body)
    post.accept_comment(Comment.new(post, self, title, body))
  end
end

class Blog 
  attr_accessor :user, :title, :postlist
  def initialize(user, title)
    @title = title
    @postlist = []
  end

  def accept_post(post)
    @postlist << post if post.is_a? Post
  end

  def header
    "<h1>#{title}</h1>"
  end

  def display
    header + postlist.map(&:shortdisplay).join
  end
end

class Post 
  attr_accessor :blog, :title, :body, :commentlist
  def initialize(blog, title, body)
    @blog = blog
    @title = title
    @body = body
    @commentlist = []
  end

  def accept_comment(comment)
    @commentlist << comment if comment.is_a? Comment
  end

  def shortdisplay
    "<p><h2>#{title}</h2>#{body.first(30)}</p>"
  end

  def display
    "<div><h2>#{title}</h2>#{body}</div><h2>Comments:</h2>" + commentlist.map(&:display).join
  end
end

class Comment 
  attr_accessor :post, :user, :title, :body
  def initialize(post, user, title, body)
    @post = post
    @user = user
    @title = title
    @body = body
  end

  def display
    "<p><h2>#{user.name } said: #{title}</h2>#{body}</p>"
  end
end
