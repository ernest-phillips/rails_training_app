Find the 
* most liked movie
SQL:
SELECT * FROM movies ORDER BY facebook_likes DESC LIMIT 1;

ActiveRecord:
Movie.order(facebook_likes: :desc).limit(1).to_sql

Scope:
scope :with_most_facebook_likes, -> { order(facebook_likes: :desc).limit(1) }

---

* directed by Christopher Nolan
SQL:
SELECT * FROM movies JOIN directors ON movies.director_id = directors.id WHERE directors.name = 'Christopher Nolan';

ActiveRecord:
Movie.joins(:director).where(directors: {name: "Christopher Nolan"})

Scope:
scope :directed_by, -> (director_name) { joins(:director).where(directors: {name: director_name }) }

---

* with the plot keyword "foul play"
SQL:
SELECT * FROM movies WHERE plot_keywords LIKE "%foul play%"

ActiveRecord:
Movie.where("plot_keywords LIKE ?", "%foul_play%")

Scope:
scope :with_plot_keyword, -> (keyword) { where("plot_keywords LIKE ?", "%#{keyword}%") }

---

All together:
SELECT * FROM movies
JOIN directors ON movies.director_id = directors.id
WHERE directors.name = 'Christopher Nolan'
AND plot_keywords LIKE "%foul play%"
ORDER BY facebook_likes DESC LIMIT 1;

All ActiveRecord:
Movie.joins(:director).where(directors: {name: "Christopher Nolan"}).where("plot_keywords LIKE ?", "%foul_play%").order(facebook_likes: :desc).limit(1)

All scopes:
Movie.directed_by("Christopher Nolan").with_plot_keyword("foul play").with_most_facebook_likes