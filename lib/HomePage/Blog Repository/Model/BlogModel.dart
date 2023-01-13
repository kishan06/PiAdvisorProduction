class Blogs {
  List<BlogAll>? blogAll;
  List<Blog1>? blog1;
  List<Blog2>? blog2;
  List<Blog3>? blog3;

  Blogs({this.blogAll, this.blog1, this.blog2, this.blog3});

  Blogs.fromJson(Map<String, dynamic> json) {
    if (json['blog_all'] != null) {
      blogAll = <BlogAll>[];
      json['blog_all'].forEach((v) {
        blogAll!.add(new BlogAll.fromJson(v));
      });
    }
    if (json['blog1'] != null) {
      blog1 = <Blog1>[];
      json['blog1'].forEach((v) {
        blog1!.add(new Blog1.fromJson(v));
      });
    }
    if (json['blog2'] != null) {
      blog2 = <Blog2>[];
      json['blog2'].forEach((v) {
        blog2!.add(new Blog2.fromJson(v));
      });
    }
    if (json['blog3'] != null) {
      blog3 = <Blog3>[];
      json['blog3'].forEach((v) {
        blog3!.add(new Blog3.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.blogAll != null) {
      data['blog_all'] = this.blogAll!.map((v) => v.toJson()).toList();
    }
    if (this.blog1 != null) {
      data['blog1'] = this.blog1!.map((v) => v.toJson()).toList();
    }
    if (this.blog2 != null) {
      data['blog2'] = this.blog2!.map((v) => v.toJson()).toList();
    }
    if (this.blog3 != null) {
      data['blog3'] = this.blog3!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BlogAll {
  int? id;
  String? title;
  String? authorName;
  String? publishDate;
  String? discription;
  String? blogImage;
  String? innerBlogImage;
  String? createdAt;
  String? updatedAt;
  int? categoryId;

  BlogAll(
      {this.id,
      this.title,
      this.authorName,
      this.publishDate,
      this.discription,
      this.blogImage,
      this.innerBlogImage,
      this.createdAt,
      this.updatedAt,
      this.categoryId});

  BlogAll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    authorName = json['author_name'];
    publishDate = json['publish_date'];
    discription = json['discription'];
    blogImage = json['blog_image'];
    innerBlogImage = json['inner_blog_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['author_name'] = this.authorName;
    data['publish_date'] = this.publishDate;
    data['discription'] = this.discription;
    data['blog_image'] = this.blogImage;
    data['inner_blog_image'] = this.innerBlogImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_id'] = this.categoryId;
    return data;
  }
}

class Blog1 {
  int? id;
  String? title;
  String? authorName;
  String? publishDate;
  String? discription;
  String? blogImage;
  String? innerBlogImage;
  String? createdAt;
  String? updatedAt;
  int? categoryId;

  Blog1(
      {this.id,
      this.title,
      this.authorName,
      this.publishDate,
      this.discription,
      this.blogImage,
      this.innerBlogImage,
      this.createdAt,
      this.updatedAt,
      this.categoryId});

  Blog1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    authorName = json['author_name'];
    publishDate = json['publish_date'];
    discription = json['discription'];
    blogImage = json['blog_image'];
    innerBlogImage = json['inner_blog_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['author_name'] = this.authorName;
    data['publish_date'] = this.publishDate;
    data['discription'] = this.discription;
    data['blog_image'] = this.blogImage;
    data['inner_blog_image'] = this.innerBlogImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_id'] = this.categoryId;
    return data;
  }
}

class Blog2 {
  int? id;
  String? title;
  String? authorName;
  String? publishDate;
  String? discription;
  String? blogImage;
  String? innerBlogImage;
  String? createdAt;
  String? updatedAt;
  int? categoryId;

  Blog2(
      {this.id,
      this.title,
      this.authorName,
      this.publishDate,
      this.discription,
      this.blogImage,
      this.innerBlogImage,
      this.createdAt,
      this.updatedAt,
      this.categoryId});

  Blog2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    authorName = json['author_name'];
    publishDate = json['publish_date'];
    discription = json['discription'];
    blogImage = json['blog_image'];
    innerBlogImage = json['inner_blog_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['author_name'] = this.authorName;
    data['publish_date'] = this.publishDate;
    data['discription'] = this.discription;
    data['blog_image'] = this.blogImage;
    data['inner_blog_image'] = this.innerBlogImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_id'] = this.categoryId;
    return data;
  }
}

class Blog3 {
  int? id;
  String? title;
  String? authorName;
  String? publishDate;
  String? discription;
  String? blogImage;
  String? innerBlogImage;
  String? createdAt;
  String? updatedAt;
  int? categoryId;

  Blog3(
      {this.id,
      this.title,
      this.authorName,
      this.publishDate,
      this.discription,
      this.blogImage,
      this.innerBlogImage,
      this.createdAt,
      this.updatedAt,
      this.categoryId});

  Blog3.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    authorName = json['author_name'];
    publishDate = json['publish_date'];
    discription = json['discription'];
    blogImage = json['blog_image'];
    innerBlogImage = json['inner_blog_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['author_name'] = this.authorName;
    data['publish_date'] = this.publishDate;
    data['discription'] = this.discription;
    data['blog_image'] = this.blogImage;
    data['inner_blog_image'] = this.innerBlogImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_id'] = this.categoryId;
    return data;
  }
}
