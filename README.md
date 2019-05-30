# Little Shop of Seeds

## Background & Description

An e-commerce site for purchasing different seed species, created by Brian Plantico, Glynnis O'Connell, James Cape, and Rob Stringer. Users are able to register, be upgraded to a merchant, as well as administrator, update their own profiles as physical addresses change, add seeds to their shopping cart and checkout, etc.

## Things We Learned!

Each contributor was able to work with authentication & authorization utilizing the bcrypt gem, nested resources, as well as namespaced resources, and furthered our knowledge of feature and model testing. Throughout creating Little Shop of Seeds, contributors worked alone and in pairs to ensure this project would be completed by our deadline, as well as broaden our knowledge of sessions, PORO's, and how developers are able to work with large databases.  

## Prerequesites

Before beginning to play around in Little Shop of Seeds, please ensure you are using the correct version of Ruby (5.1.7), all gems are installed, etc. After forking and cloning this repository, please run the following commands:

```
bundle install
```
<a><img src="https://user-images.githubusercontent.com/46202598/58635354-e801e400-82aa-11e9-84c5-cb2556c4ffd9.png" alt="bundle" width="400" ></a>

<a><img src="https://user-images.githubusercontent.com/46202598/58635415-0ec01a80-82ab-11e9-94c1-e319cd79b5dd.png" alt="bundle installed" width="400" ></a>

```
bundle update
```

<a><img src="https://user-images.githubusercontent.com/46202598/58635480-3b743200-82ab-11e9-9a52-dc36ece468a8.png" alt="bundle update" width="400" ></a>
<a><img src="https://user-images.githubusercontent.com/46202598/58635442-27c8cb80-82ab-11e9-8365-e33484533eff.png" alt="bundle updated" width="400" ></a>


Once all gems have been installed and updated, you will want to then run the following command to begin to work with the databases:

```
rails db:{create,migrate,seed}
```
<a><img src="https://user-images.githubusercontent.com/46202598/58635729-d66d0c00-82ab-11e9-8ccf-225c8337f318.png" alt="rails db" width="400" ></a>

In order to test and begin adding new methods that could be included in Little Shop of Seeds, you will want to include

```
require 'rails_helper'
```
![image](https://user-images.githubusercontent.com/46202598/58635779-f56b9e00-82ab-11e9-9111-8105e16a2d14.png)


At the top of every spec file. As this project was tested using rspec, all tests files need to end in spec.rb in order to ensure these files will be run with the test suite and your new methods are tested accurately. In order to run your tests, simply enter rspec in your command line/terminal and wait for the little green dots to start your test-driven development with Little Shop of Seeds!

## Link to deployed product:

[Link to deployed project](https://secret-beach-64798.herokuapp.com/)

<a><img src="https://user-images.githubusercontent.com/46202598/58635841-2350e280-82ac-11e9-95b4-e7aa28ff1fbb.png" alt="rails db" width="400" ></a>
