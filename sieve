require ["envelope", "imapflags", "fileinto", "reject", "notify", "vacation", "regex", "relational", "comparator-i;ascii-numeric", "body", "copy"];

# Anti Spam
# ---------
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
elsif header :matches "from" ["*@linkedin.com", "*@plus.google.com"] {
  fileinto "INBOX.Trash";
}
# TUNA issues
elsif header :matches "from" "issues+*@tuna.tsinghua.edu.cn" {
  keep;
  setflag "Seen";
  fileinto "INBOX.Work.tuna-issues";
}
# Github
elsif header :is "from" ["notifications@github.com"] {
  fileinto "INBOX.Work.Github";
}
# Mailing lists
# {
# TUNA
elsif header :is ["list-id", "list-post"] ["<tuna-general.googlegroups.com>"] {
  # discard mail sent by me than received from mailing list again
  if header :is "from" ["i@bigeagle.me"]
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
  if header :is "from" ["i@bigeagle.me"]
  {
    discard;
  } else {
    fileinto "INBOX.Org.xdlinux";
  }
}
# USTC
elsif header :is ["list-id", "list-post"] ["<ustc_lug.googlegroups.com>"] {
  # discard mail sent by me than received from mailing list again
  if header :is "from" ["i@bigeagle.me"]
  {
    discard;
  } else {
    fileinto "INBOX.Org.USTC";
  }
} 
# }
# Subscriptions
# {
elsif header :regex "subject" "^(IEEE)|(\\[EDAS-CFP\\])" {
  fileinto "INBOX.Work.Academic";
}
elsif header :matches "from" "*@pycoders.com" {
  fileinto "INBOX.News.Pycoders";
}
elsif header :regex "subject" "^Go Newsletter Issue" {
  fileinto "INBOX.News.GoNewsletter";
}
elsif header :is ["list-id", "list-post"] "<arch-announce.archlinux.org>" {
  fileinto "INBOX.News.Arch-announce";
}
elsif header :contains ["list-id", "list-post"] "xqhs.mails.tsinghua.edu.cn" {
  fileinto "INBOX.News.NewTHU";
}
elsif header :is "from" "noreply@batch.manong.io" {
  fileinto "INBOX.News.CoderNews";
}
elsif allof (
  header :is "from" "no-reply@arxiv.org",
  header :regex "subject" "^cs daily Subj-class mailing"
) {
  fileinto "INBOX.News.Arxiv";
}
# }

# vim: ft=sieve expandtab sts=2 ts=2 sw=2
