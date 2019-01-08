CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT name, size from dogs, sizes where min < height and height <= max;

-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child from parents, dogs where parent = name ORDER BY -height;

-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT a.child as child1, b.child as child2
  from parents as a, parents as b
  where a.parent = b.parent and b.child > a.child;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT child1 || " and " || child2 || " are " || e.size || " siblings"
  from siblings, size_of_dogs as b, size_of_dogs as e
  where b.size = e.size and b.name = child1 and e.name = child2;

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks_helper(dogs, stack_height, last_height);
  INSERT INTO stacks_helper
    SELECT name as dogs, height as stack_height, height as last_height
    from dogs;

-- Add your INSERT INTOs here
  INSERT INTO stacks_helper
    SELECT dogs|| ", " || b.name, stack_height + b.height, b.height
    from dogs as b, stacks_helper
    where last_height < b.height;


  INSERT INTO stacks_helper
    SELECT dogs || ", " || c.name, stack_height + c.height, c.height
    from dogs as c, stacks_helper
    where last_height < c.height;

  INSERT INTO stacks_helper
    SELECT dogs ||", "|| d.name, stack_height + d.height, d.height
    from dogs as d, stacks_helper
    where last_height < d.height;

CREATE TABLE stacks AS
  SELECT dogs, stack_height from stacks_helper where stack_height >= 170 order by stack_height;
