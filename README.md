# Slack

This gem allows you to send messages as a bot in Slack.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slack', github: 'Educatea/slack' 
```

And then execute:

    $ bundle

## Usage

```ruby
# Set a token:
Slack.set_token('xxxx-xxxxxxxxxx-xxxxxXxxxxxxxxXXxXxXXxXX')     
   
# You can also add your Token to your application.rb   
ENV['SLACK_TOKEN'] = 'xxxx-xxxxxxxxxx-xxxxxXxxxxxxxxXXxXxXXxXX'
  
# And set it:
Slack.set_token     

# Send message to user:
Slack.send_message_to_user(<SLACK-USERNAME>,<MESSAGE-BODY>)     

# Send message to channel:
Slack.send_message_to_channel(<SLACK-CHANNEL-NAME>,<MESSAGE-BODY>)
```

## Example

```ruby
# First let's set the token:    
Slack.set_token('xxxx-xxxxxxxxxx-xxxxxXxxxxxxxxXXxXxXXxXX')   

# Let's see if it was set correctly:   
Slack.show_token
# => 'xxxx-xxxxxxxxxx-xxxxxXxxxxxxxxXXxXxXXxXX'
    
# You can also check if the connection with Slack was established succesfully:    
Slack.show_rtm.ok   
# => true
    
# You can now easily send a message to a user knowing their username
Slack.send_message_to_user('juangesino',"Hey!")
   
# Or to a channel 
Slack.send_message_to_channel('general',"Hello everyone!")
   
# With this gem you can even mention people and channels 
Slack.send_message_to_channel('general',"Hello everyone at #general! Specially you @juangesino")

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Details

Created by [Juan Gesino](https://github.com/juangesino) for [Educatea](http://educatea.com.ar)

## Contributing

1. Fork it ( https://github.com/educatea/educatea/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
