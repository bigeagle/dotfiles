require ["envelope", "imapflags", "fileinto", "reject", "notify", "vacation", "regex", "relational", "comparator-i;ascii-numeric", "body", "copy", "subaddress"];

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
if header :regex "from" "(wanghanatbupt@gmail.com)|(bibaijin@gmail.com)|(kaizhang91@163.com)|(zhangk13@mails.tsinghua.edu.cn)" {
  fileinto "INBOX.THUEE";
} 
# Useless
elsif address :matches "from" ["*@linkedin.com", "*@plus.google.com"] {
  fileinto "INBOX.Trash";
}
# Github
elsif address :is "from" ["notifications@github.com"] {
  fileinto "INBOX.Work.Github";
}
# AUR
elsif address :is "from" ["notify@aur.archlinux.org"] {
  fileinto "INBOX.Community.AUR";
}
# TUNAIVE
elsif address :is "to" ["tunaive@bigeagle.me", "i+tunaive@bigeagle.me"] {
  fileinto "INBOX.Work.Tunaive";
}
# Jobs
elsif allof (
  address :domain "to" "bigeagle.me",
  address :user "to" "job"
) {
  fileinto "INBOX.Work.Jobs";
}
# TUNA workmail
elsif allof (
  address :matches ["to", "cc", "bcc"] ["*@tuna.tsinghua.edu.cn"],
  address :is "from" ["yuzhi.wang@tuna.tsinghua.edu.cn", "i@bigeagle.me"]
) {
  discard;
  # discard duplicated mails sent from me
}
# Shetuan
elsif address :contains ["to", "from"] ["shetuan@mail.tsinghua.edu.cn"] {
  fileinto "INBOX.Work.Shetuan";
}
# Mailing lists
# {
# TUNA
elsif header :contains ["list-id", "list-post"] ["<tuna-general.googlegroups.com>"] {
  # discard mail sent by me than received from mailing list again
  if address :is "from" ["i@bigeagle.me"]
  {
    discard;
  } else {
    fileinto "INBOX.Org.TUNA";
    notify :method "mailto"
           :options ["trigger@recipe.ifttt.com"]
           :message "/New mail in tuna-general #tuna/";
  }
}
# xdlinux
elsif header :contains ["list-id", "list-post"] ["<xidian_linux.googlegroups.com>"] {
  if header :is "from" ["i@bigeagle.me"]
  {
    discard;
  } else {
    fileinto "INBOX.Org.xdlinux";
  }
}
# USTC
elsif header :contains ["list-id", "list-post"] ["<ustc_lug.googlegroups.com>"] {
  # discard mail sent by me than received from mailing list again
  if address :is "from" ["i@bigeagle.me"]
  {
    discard;
  } else {
    fileinto "INBOX.Org.USTC";
  }
}
# centos-mirrors
elsif header :contains ["list-id", "list-post"] ["<centos-mirror.centos.org>"] {
  if address :is "from" ["i@bigeagle.me", "mirroradmin@tuna.tsinghua.edu.cn"]
  {
    discard;
  } else {
    fileinto "INBOX.Community.centos-mirror";
  }
}
elsif header :contains ["list-id", "list-post"] ["<arch-mirrors.archlinux.org>"] {
  if address :is "from" ["i@bigeagle.me", "mirroradmin@tuna.tsinghua.edu.cn"]
  {
    discard;
  } else {
    fileinto "INBOX.Community.arch-mirror";
  }
}
elsif header :contains ["list-id", "list-post"] ["<arch-mirrors.archlinux.org>"] {
  if address :is "from" ["i@bigeagle.me", "mirroradmin@tuna.tsinghua.edu.cn"]
  {
    discard;
  } else {
    fileinto "INBOX.Community.arch-mirror";
  }
}
elsif address :matches "to" "mirror@opensuse.org" {
  if address :is "from" ["i@bigeagle.me", "mirroradmin@tuna.tsinghua.edu.cn"]
  {
    discard;
  } else {
    fileinto "INBOX.Community.suse-mirror";
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
elsif header :contains ["list-id", "list-post"] "<arch-announce.archlinux.org>" {
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
