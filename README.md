# dependz
ruby dependency management gem.

Topological sorting for dependency relations.

## Requirement

- ruby => 2.4

## installation

### Manual
`gem install dependz`
### Bundle
`gem 'dependz'`

## usage

### sort_item

Produce a topologically sorted list of all item stored in the Dependz::Client instance.

Meaning for every dependency A depends on B, A always appear after B in the `sort_item` result.

```
irb:001 > require 'Dependz'

irb:002 > my_morning = Dependz::Client.new

irb:003 > my_morning.add(depend_by: 'make breakfast', depend_on: 'wake up')

irb:004 > my_morning.add(depend_by: 'make breakfast', depend_on: 'brush teeth and wash my face')

irb:005 > my_morning.add(depend_by: 'eat breakfast', depend_on: ['have my coffee', 'make breakfast', 'check my schedule'])

irb:006 > my_morning.add(depend_by: 'brush teeth and wash my face', depend_on: 'wake up')

irb:007 > my_morning.add(depend_by: 'wash the dishes', depend_on: 'eat breakfast')

irb:008 > my_morning.add(depend_by: 'dress up', depend_on: 'have my coffee')

irb:09 > my_morning.add(depend_by: 'make coffee', depend_on: 'wake up')

irb:0010 > my_morning.add(depend_by: 'have my coffee', depend_on: 'make coffee')

irb:0011 > my_morning.add(depend_by: 'check my schedule', depend_on: 'have my coffee')

irb:0012 > my_morning.add(depend_by: 'start my day', depend_on: ['have my coffee', 'dress up', 'check my schedule', 'eat breakfast', 'brush teeth and wash my face'])

irb:0014 > my_morning.sort_item
=> [
     "wake up",
     "brush teeth and wash my face",
     "make breakfast",
     "make coffee",
     "have my coffee",
     "check my schedule",
     "eat breakfast",
     "wash the dishes",
     "dress up",
     "start my day"
   ]
```

### sort_level

Produce an array of arrary.

Similar to `sort_item` but all items that are on the same level in Topology sort are grouped together.

Items that does not depends on anything will appear on the first level. Items only depends on items on the first level will appear on the second level and so on.

On each level, all item are independ of each other.


```
irb:001 > require 'Dependz'

irb:002 > make_omelette = Dependz::Client.new

irb:003 > make_omelette.add(depend_by: 'cook egge', depend_on: 'whisk eggs')

irb:004 > make_omelette.add(depend_by: 'stir mushroom', depend_on: 'wash and chop mushroom')

irb:005 > make_omelette.add(depend_by: 'put stired mushroom aside', depend_on: 'stir mushroom')

irb:006 > make_omelette.add(depend_by: 'add cooked mushroom', depend_on: 'put stired mushroom aside')

irb:007 > make_omelette.add(depend_by: ['add cooked mushroom', 'add cheese'], depend_on: 'cook egge')

irb:008 > make_omelette.add(depend_by: 'serve the omelette', depend_on: ['add cheese', 'add cooked mushroom'])

irb:009 > make_omelette.sort_level
=> [
     ["whisk eggs", "wash and chop mushroom"],
     ["cook egge", "stir mushroom"],
     ["add cheese", "put stired mushroom aside"],
     ["add cooked mushroom"],
     ["serve the omelette"]
   ] 
```

#### Hypothetical use case
Suppose we have a task processing service call MagicalRobotArmy that can perform tasks asynchronously in parallel. 

Using the `make_omelette` object we create in the previous example, now I can have my omelette prepared by the MagicalRobotArmy paralell manner.

In real application, you can swich MagicalRobotArmy with any background task processing service.

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