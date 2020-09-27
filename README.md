# depends
ruby dependency management gem.

Topoligical sorting for dependent relations.

## installation

### Requirement

- ruby => 2.4

### Manual
`gem install depends`
### Bundle
`gem 'pry'`

## usage

### sort_item

Produce a topologically sorted list of all item stored in the Dependz::Client instance.
Meaning for every dependency A depends on B, A always appear after B in the `sort_item` result.

```
irb:001 > require 'Dependz'

irb:002 > my_morning = Dependz::Client.new

irb:003 > my_morning.add(depend_by: 'make breakfast', depend_on: 'wake up')

irb:004 > my_morning.add(depend_by: 'eat breakfast', depend_on: 'wash up')

irb:005 > my_morning.add(depend_by: 'eat breakfast', depend_on: 'wake up')

irb:006 > my_morning.add(depend_by: 'wash up', depend_on: 'wake up')

irb:007 > my_morning.add(depend_by: 'clean kitchen', depend_on: 'make breakfast')

irb:008 > my_morning.add(depend_by: 'wash the dishes', depend_on: 'eat breakfast')

irb:009 > my_morning.add(depend_by: 'dress up', depend_on: 'wash up')

irb:0010 > my_morning.add(depend_by: 'walk my dog', depend_on: 'wash up')

irb:0011 > my_morning.add(depend_by: 'make coffee', depend_on: 'wake up')

irb:0012 > my_morning.add(depend_by: 'have my coffee', depend_on: 'make coffee')

irb:0013 > my_morning.add(depend_by: 'check my schedule', depend_on: 'have my coffee')

irb:0013 > my_morning.add(depend_by: 'start my day', depend_on: ['have my coffee', 'walk my dog', 'dress up', 'check my schedule', 'eat breakfast', 'wash up'])

irb:0014 > my_morning.sort_item
=>  ["wake up", "make breakfast", "clean kitchen", "wash up", "eat breakfast", "wash the dishes", "walk my dog", "dress up", "make coffee", "have my coffee", "check my schedule", "start my day"] 
```
