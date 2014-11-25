application_static cookbook
===========================
supermarket: https://supermarket.getchef.com/cookbooks/application_static  
github:  https://github.com/allnightlong/application_static

This is the simple chef cookbook to quick host static web sites with nginx. Based on excellent [application cookbook](https://github.com/poise/application), which is only providing LWRPs, this cookbook actually  has recipe.  

So after defining it with Berkshelf/Librarian, you have to provide as minimal config as possible, to make your sites up and running.


config
======
Let's imagine you have several static websites, you want to host, each in it's own repository:

```
example1.com -> github.com/my-sites/example1.com
example2.com -> bitbucket.org/my-sites/example2.com
...
```

To get them running, you should do 3 simple steps.
### 1. adding cookbook
First thing todo, is adding application_static cookbook to your chef installation.  
Berkshelf example:

```ruby
cookbook "application_static"
```

### 2. create role
Then create appropriate role:

```json
{
  "name": "static_sites",
  "override_attributes": {
    "nginx": {
      "default_site_enabled": false,
      "install_method": "repo"
    },
    "application_static": {
      "apps": [
        {
          "name": "example1.com",
          "url": "git@github.com:my-sites/example1.com",
          "enabled": true
        },
        {
          "name": "example2.com",
          "url": "hg@bitbucket.org/my-sites/example2.com",
          "enabled": true
        }
      ],
      "deploy_key" : "-----BEGIN RSA PRIVATE KEY-----\nMIIEowIBAAKCAQEA38rGcWTe5Iux2MtIgmbl08P0f3KZfJBCIvKES9oFFglqAbI7\n...........\n5qJkpABldGtXpWxrllpFvWDGSWdv8WYJW308dXIp2C5LjE3saTuhBTgain7GDs6P\np5lXlrB0zUGU92likbgEvIFN0lzkpYt02ccxTCCU6bIa9pTI3IBK\n-----END RSA PRIVATE KEY-----"
    }
  },
  "run_list": [
    "recipe[nginx]",
    "recipe[application_static]"
  ]
}
```

Note that you shouldn't really store private key in role file, in favor of [databags](https://docs.getchef.com/essentials_data_bags.html) or even better [encrypted databags](https://docs.getchef.com/essentials_data_bags.html#encrypt-a-data-bag-item).  
Also, if you getting troubles with multiline private key, use [this tip](https://tickets.opscode.com/browse/CHEF-3540).

### 3. apply role

```
knife node run_list add NODE_NAME role[static_sites]
```

That's basically it. After adding this role to node's run-list, your sites should be up and running.  
This cookbook was tested on Ubuntu 14.04 LTS, but there is nothing os/platform/version specific, so it should work on any environment.  
[Pull-requests](https://github.com/allnightlong/application_static/pulls) are very warm welcome.
