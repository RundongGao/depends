# depends
ruby dependency management gem.

Topoligical sorting for dependent relations.

## Requirement

- ruby => 2.4

## installation

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
=> ["wake up", "make breakfast", "clean kitchen", "wash up", "eat breakfast", "wash the dishes", "walk my dog", "dress up", "make coffee", "have my coffee", "check my schedule", "start my day"] 
```

### sort_level

Produce an array of arrary.

Similar to `sort_item` but all items that are on the same level in topology sort are grouped together.

Items that does not depends on anything will appear on the first level. Items only depends on items on the first level will appear on the second level and so on.

On each level, all item are independ of each other.


```
irb:001 > require 'Dependz'

irb:002 > make_omelette = Dependz::Client.new

irb:003 > make_omelette.add(depend_by: 'stir egge', depend_on: 'whisk eggs')

irb:004 > make_omelette.add(depend_by: 'stir mushroom', depend_on: ['wash up', 'wash and chop mushroom'])

irb:005 > make_omelette.add(depend_by: 'put stired mushroom aside', depend_on: 'stir mushroom')

irb:006 > make_omelette.add(depend_by: 'add mushroom', depend_on: 'put stired mushroom aside')

irb:007 > make_omelette.add(depend_by: ['add mushroom', 'add cheese'], depend_on: 'stir egge')

irb:008 > make_omelette.add(depend_by: 'serve the omelette', depend_on: ['add cheese', 'add mushroom'])

irb:009 > make_omelette.sort_level
=> [
  ["whisk eggs", "wash up", "wash and chop mushroom"],
  ["stir egge", "stir mushroom"],
  ["add cheese", "put stired mushroom aside"],
  ["add mushroom"],
  ["serve the omelette"]
] 
```

#### Hypothetical use case
Suppose we have a task execution service call MagicalRobotArmy that can perform tasks asynchronously in parallel. 

Using the `make_omelette` object we create in the previous example, new I can my omelette prepared by the in MagicalRobotArmy paralell manner.

```
plan = make_omelette.sort_level

loop do
  return if plan.empty?
  sleep(10) unless MyMagicalRobotArmy.all_done?

  plan.shift.each do |task|
    MyMagicalRobotArmy.perform_async(task)
  end
end
```