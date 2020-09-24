# depends
ruby dependency management gem.


## installation

### Manual
`gem install depends`
### Bundle
`gem 'pry'`

## usage

```
irb:001 > require 'Depends'

irb:002 > my_morning = Depends.new

irb:003 > my_morning.add(depends_by: 'make breakfast', depends_on: 'wake up')

irb:004 > my_morning.add(depends_by: 'eat breakfast', depends_on: 'wash up')

irb:005 > my_morning.add(depends_by: 'eat breakfast', depends_on: 'wake up')

irb:006 > my_morning.add(depends_by: 'wash up', depends_on: 'wake up')

irb:007 > my_morning.add(depends_by: 'clean kitchen', depends_on: 'make breakfast')

irb:008 > my_morning.add(depends_by: 'wash the dishes', depends_on: 'eat breakfast')

irb:009 > my_morning.add(depends_by: 'dress up', depends_on: 'wash up')

irb:0010 > my_morning.add(depends_by: 'walk my dog', depends_on: 'wash up')

irb:0011 > my_morning.add(depends_by: 'make coffee', depends_on: 'wake up')

irb:0012 > my_morning.add(depends_by: 'have my coffee', depends_on: 'make coffee')

irb:0013 > my_morning.add(depends_by: 'check my schedule', depends_on: 'have my coffee')

irb:0014 > my_morning.sort
=> ["wake up", "make breakfast", "clean kitchen", "wash up", "eat breakfast", "wash the dishes", "dress up", "walk my dog", "make coffee", "have my coffee", "check my schedule"] 
```
