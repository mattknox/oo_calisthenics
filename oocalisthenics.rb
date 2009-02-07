# He suggests writing a 1000-line program with the constraints listed below. These constraints are intended to be excessively restrictive, so as to force developers out of the procedural groove. I guarantee if you apply this technique, their code will move markedly towards object orientation. The restrictions (which should be mercilessly enforced in this exercise) are:

# 1. Use only one level of indentation per method. If you need more than one level, you need to create a second method and call it from the first. This is one of the most important constraints in the exercise.

# 2. Don't use the 'else' keyword. Test for a condition with an if-statement and exit the routine if it's not met. This prevents if-else chaining; and every routine does just one thing. You're getting the idea.

# 3. Wrap all primitives and strings. This directly addresses "primitive obsession." If you want to use an integer, you first have to create a class (even an inner class) to identify it's true role. So zip codes are an object not an integer, for example. This makes for far clearer and more testable code.

# 4. Use only one dot per line. This step prevents you from reaching deeply into other objects to get at fields or methods, and thereby conceptually breaking encapsulation.

# 5. Don't abbreviate names. This constraint avoids the procedural verbosity that is created by certain forms of redundancy-if you have to type the full name of a method or variable, you're likely to spend more time thinking about its name. And you'll avoid having objects called Order with methods entitled shipOrder(). Instead, your code will have more calls such as Order.ship().

# 6. Keep entities small. This means no more than 50 lines per class and no more than 10 classes per package. The 50 lines per class constraint is crucial. Not only does it force concision and keep classes focused, but it means most classes can fit on a single screen in any editor/IDE.

# 7. Don't use any classes with more than two instance variables. This is perhaps the hardest constraint. Bay's point is that with more than two instance variables, there is almost certainly a reason to subgroup some variables into a separate class.

# 8. Use first-class collections. In other words, any class that contains a collection should contain no other member variables. The idea is an extension of primitive obsession. If you need a class that's a subsumes the collection, then write it that way.

# 9. Don't use setters, getters, or properties. This is a radical approach to enforcing encapsulation. It also requires implementation of dependency injection approaches and adherence to the maxim "tell, don't ask."

# Taken together, these rules impose a restrictive encapsulation on developers and force thinking along OO lines. I assert than anyone writing a 1000-line project without violating these rules will rapidly become much better at OO. They can then, if they want, relax the restrictions somewhat. But as Bay points out, there's no reason to do so. His team has just finished a 100,000-line project within these strictures.

# fake primitives: timestamp name body title email comment_list post_list blog_list

class Timestamp
  attr_reader :created_at, :updated_at

  def initialize
    @created_at = DateTime.now
    @updated_at = DateTime.now
  end

  def set_updated_at!
    @updated_at = DateTime.now
  end

  def display
    created_at.to_s
  end
end

class Name
  attr_reader :content

  def initialize(content)
    @content = content
  end

  def content=(str)
    t = str.to_s
    if str.is_a? String
      @content = str
    end
  end

  def display
    content.to_s
  end
end

class Body
  attr_reader :content

  def initialize(content)
    @content = content
  end

  def append(str)
    @content += str
  end
  
  def content=(str)
    t = str.to_s
    if str.is_a? String
      @content = str
    end
  end

  def display
    content.to_s
  end
end

class Title
  attr_reader :content

  def initialize(content)
    @content = content
  end

  def content=(str)
    t = str.to_s
    if str.is_a? String
      @content = str
    end
  end

  def display
    content.to_s
  end
end

class Email
  attr_reader :content

  def initialize(content)
    @content = content
  end

  def content=(str)
    t = str.to_s
    if str.is_a? String
      @content = str
    end
  end

  def display
    content.to_s
  end
end

class CommentList
  def initialize
    @commentlist = []
  end

  def count
    @commentlist.length
  end
  
  def <<(item)
    if item.is_a? Comment
      @commentlist << item
    end
  end

  def elements
    @commentlist
  end

  def display
  end
end

class PostList
  def initialize
    @postlist = []
  end

  def count
    @postlist.length
  end
  
  def <<(item)
    if item.is_a? Post
      @postlist << item
    end
  end

  def display
  end
end

class BlogList
  def initialize
    @bloglist = []
  end

  def count
    @bloglist.length
  end
  
  def <<(item)
    if item.is_a? Blog
      @bloglist << item
    end
  end

  def display
  end
end

# combiner objects, which combine 2 primitives
# bodytitle, postcontents, blog_contents, core_attributes, comment_attributes

class BodyTitle
  # this is a container for the title and body of a post.
  attr_reader :body, :title
  def initialize(body, title)
    @body = Body.new(body)
    @title = Title.new(title)
  end

  def append_to_body(str)
    body.append(str)
  end

  def body=(str)
    body = Body.new(str)
  end

  def title=(str)
    title = Title.new(str)
  end

  def display
  end
end

class CoreAttributes
  # this is a container for a user and a set of timestamps.  Both Comment and Post have one.
  attr_reader :timestamp, :user
  def initialize(user)
    @user = user
    @timestamp = Timestamp.new
  end

  def set_updated_at!
    timestamp.set_updated_at!
  end
end

class CommentAttributes
  attr_reader :core_attributes, :post

  def initialize(user, post)
    @post = post
    @core_attributes = CoreAttributes.new(user)
  end

  def set_updated_at!
    core_attributes.set_updated_at!
  end
end

class UserAttributes
  attr_reader :email, :name

  def initialize(name, email)
    @name = Name.new(name)
    @email = Email.new(email)
  end

  def email=(str)
    email = Email.new(str)
  end

  def name=(str)
    name = Name.new(str)
  end

  def display
  end
end

class PostContents
  # this holds a list of comments and the BodyTitle object
  attr_reader :body_title, :comment_list

  def initialize(body, title)
    @comment_list = CommentList.new
    @body_title = BodyTitle.new(body, title)
  end

  def add_comment(comment)
    comment_list << comment
  end

  def append_to_body(str)
    body_title.append_to_body(str)
  end

  def comments
    comment_list.elements
  end

  def display
  end
end

class BlogContents
  attr_reader :title, :postlist

  def initialize(title)
    @title = Title.new(title)
    @postlist = Postlist.new
  end

  def add_post(post)
    @postlist.add_post(post)
  end
  def display
  end
end

class BlogsComments
  # this is a list of a users blogs and comments
  attr_reader :bloglist, :commentlist

  def initialize
    @bloglist = BlogList.new
    @commentlist = CommentList.new
  end

  def add_blog(blog)
    @bloglist << blog
  end

  def add_comment(comment)
    @commentlist << comment
  end

  def display
  end
end

# actual models: user profile blog post comment
class Comment
  # conceptually, this has created_at, updated_at, body, user, post
  attr_reader :comment_attributes, :body

  def initialize(user, post, body)
    @body = Body.new(body)
    @comment_attributes = CommentAttributes.new(user, post)
  end

  def body=(str)
    @body = Body.new(str)
    comment_attributes.set_updated_at!
  end

  def append_to_body(str)
    body.append(str)
    comment_attributes.set_updated_at!
  end

  def display
  end
end

class Post
  # conceptually, this has created_at, updated_at, body, title, user, and a list of comments.  Maybe the blog, too?
  attr_reader :core_attributes, :post_contents
  
  def initialize(user, body, title)
    @core_attributes = CoreAttributes.new(user)
    @post_contents = PostContents.new(body, title)
  end

  def add_comment(comment)
    post_contents.add_comment(comment)
  end

  def body=(str)
    @body = Body.new(str)
    core_attributes.set_updated_at!
  end
  
  def append_to_body(str)
    post_contents.append_to_body(str)
    core_attributes.set_updated_at!
  end
  
  def set_updated_at!
    core_attributes.set_updated_at!
  end

  def display
  end

  def displayshort
  end
end

class Blog
  # conceptually, this has created_at, updated_at, title, user, and a list of posts
  attr_reader :blog_contents, :core_attributes

  def initialize(user, title)
    @core_attributes = CoreAttributes.new(user)
    @blog_contents = BlogContents.new(title)
  end

  def add_post(post)
    BlogContents.add_post(post)
  end

  def set_updated_at!
    core_attributes.set_updated_at!
  end

  def display
  end
end

class Profile
  # conceptually, this has created_at, updated_at, email, user
  attr_reader :core_attributes, :user_attributes

  def initialize(user, name, email)
    @user_attributes = UserAttributes.new(name, email)
    @core_attributes = CoreAttributes.new(user)
  end

  def set_updated_at!
    core_attributes.set_updated_at!
  end
end

class User
  # conceptually, this has created_at, updated_at, name, profile, a list of blogs, and a list of comments
  attr_reader :profile, :blogs_comments

  def initialize(name, email)
    @profile = Profile.new(self, name, email)
    @blogs_comments = BlogsComments.new
  end

  def create_blog(title)
    new_blog = Blog.new(title)
    blogs_comments.add_blog(new_blog)
  end

  def post(blog, title, body)
    post = Post.new(self, title, body)
    blog.accept_post(post)
  end
  
  def comment(post, body)
    comment = Comment.new(self, post, body)
    post.add_comment(comment)
  end
end
