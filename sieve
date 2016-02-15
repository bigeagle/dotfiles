require ["envelope", "imapflags", "fileinto", "reject", "notify", "vacation", "regex", "relational", "comparator-i;ascii-numeric", "body", "copy"];

# Anti Spam
# ---------
if address :matches "from" ["*@boaunit.com", "*@boa.com"] {
  fileinto "INBOX.Trash";
  stop;
}
if not header :contains ["X-Spam-known-sender"] "yes" {
  if allof(
    header :contains ["X-Backscatter"] "yes",
    not header :matches ["X-LinkName"] "*" 
  ) {
    fileinto "INBOX.Spam";
    stop;
  }
  if  header :value "ge" :comparator "i;ascii-numeric" ["X-Spam-score"] ["5"]  {
    fileinto "INBOX.Spam";
    stop;
  }
}
# ---------


# Department Notifications
if header :regex "from" "(wanghanatbupt@gmail.com)|(bibaijin@gmail.com)|(kaizhang91@163.com)" {
  fileinto "INBOX.THUEE";
} 
# Useless
elsif address :matches "from" ["*@linkedin.com", "*@plus.google.com"] {
  fileinto "INBOX.Trash";
}
# TUNA issues
elsif address :matches "from" "issues+*@tuna.tsinghua.edu.cn" {
  keep;
  setflag "Seen";
  fileinto "INBOX.Work.tuna-issues";
}
# Github
elsif address :is "from" ["notifications@github.com"] {
  fileinto "INBOX.Work.Github";
}
# Mailing lists
# {
# TUNA
elsif header :is ["list-id", "list-post"] ["<tuna-general.googlegroups.com>"] {
  # discard mail sent by me than received from mailing list again
  if address :is "from" ["i@bigeagle.me"]
  {
    discard;
  } else {
    keep;
    setflag "Seen";
    fileinto "INBOX.Org.TUNA";
  }
}
# xdlinux
elsif header :is ["list-id", "list-post"] ["<xidian_linux.googlegroups.com>"] {
  if address :is "from" ["i@bigeagle.me"]
  {
    discard;
  } else {
    fileinto "INBOX.Org.xdlinux";
  }
}
# USTC
elsif header :is ["list-id", "list-post"] ["<ustc_lug.googlegroups.com>"] {
  # discard mail sent by me than received from mailing list again
  if address :is "from" ["i@bigeagle.me"]
  {
    discard;
  } else {
    fileinto "INBOX.Org.USTC";
  }
} 
# }
# Subscriptions
# {
elsif anyof (
  header :regex "subject" "^\\[EDAS-CFP\\]",
  address :contains "from" "IEEE",
  address :domain "from" "ieee.org"
) {
  fileinto "INBOX.Work.Academic";
}
elsif address :matches "from" "*@pycoders.com" {
  fileinto "INBOX.News.Pycoders";
}
elsif anyof (
  header :regex "subject" "^Go Newsletter Issue",
  address :domain "from" "golangweekly.com"
) {
  fileinto "INBOX.News.GoNewsletter";
}
elsif header :is ["list-id", "list-post"] "<arch-announce.archlinux.org>" {
  fileinto "INBOX.News.Arch-announce";
}
elsif header :contains ["list-id", "list-post"] "xqhs@mails.tsinghua.edu.cn" {
  fileinto "INBOX.News.NewTHU";
}
elsif address :is "from" "noreply@batch.manong.io" {
  fileinto "INBOX.News.CoderNews";
}
elsif allof (
  address :is "from" "no-reply@arxiv.org",
  header :regex "subject" "^cs daily Subj-class mailing"
) {
  fileinto "INBOX.News.Arxiv";
}
# }

# vim: ft=sieve expandtab sts=2 ts=2 sw=2
