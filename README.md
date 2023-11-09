This is a quick test application generated to allow users to view fizzbuzz values with the range they set.

# Step 1: Clone the Git repository to your local machine
git clone https://github.com/your-username/your-repository.git

# Step 2: Change into the project directory
cd your-repository

# Step 3: Install the project's dependencies
mix deps.get

# Step 4: Start the Phoenix application
mix phx.server

# Step 5: Open your browser and navigate to the application's URL (http://127.0.0.1:4000)

![image](https://github.com/johnlewizz/elixir_fizz_buzz/assets/28037155/3ea9f100-8eb7-4a10-8003-58425f863b68)

Should show you the home page with the first 100 values
enter the start range and end range of values you wish to see

To favourite a number just click on the heart icon next to the number to unfavourite just click again

Files of importance are:
UI
lib\elixir_fizz_buzz_web\live\fizz_buzz_live.ex
lib\elixir_fizz_buzz_web\live\fizz_buzz_form_component.ex
lib\elixir_fizz_buzz_web\live\fizz_buzz_pagination_component.ex
lib\elixir_fizz_buzz_web\live\fizz_buzz_table_component.ex

Fizz Buzz calculation
lib\elixir_fizz_buzz\fizz_buzz\fizz_buzz_generator.ex

Favourites Cache
lib\elixir_fizz_buzz\fizz_buzz\favourites_cache.ex

JSON API
lib\elixir_fizz_buzz_web\controllers\fizz_buzz_controller.ex
