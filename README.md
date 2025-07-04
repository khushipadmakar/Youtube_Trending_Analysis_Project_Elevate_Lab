# Youtube_Trending_Analysis_Project_Elevate_Lab

## 🎯 Objective

Uncover patterns in trending YouTube videos by analyzing datasets from different regions. This project focuses on understanding video performance, content popularity, and audience sentiment using data science techniques.

---

## 🛠️ Tools Used

- **Python** (Pandas, Matplotlib, Seaborn, TextBlob)
- **SQL** (SQLite via `sqlite3`)
- **Power BI** (or Tableau) for dashboards
- **Jupyter Notebook** for exploration and scripting

---

## 📊 Steps Followed

### 1. Data Cleaning & Standardization
- Parsed and standardized date formats (`publish_time`, `trending_date`)
- Removed rows with missing or invalid dates
- Added new features such as:
  - `publish_date`
  - `days_to_trend` (how many days after publishing a video started trending)

### 2. Sentiment Analysis
- Used **TextBlob** to analyze sentiment polarity of video titles and tags.
- Added `title_sentiment` score to the dataset.

### 3. SQL-Based Insights
- Loaded the dataset into an in-memory SQLite database.
- Used SQL queries to rank video **categories** by **average views**.

### 4. Time-Series Visualization
- Plotted average daily views of trending videos.
- Used **Seaborn** and **Matplotlib** to explore trends over time.

### 5. Dashboarding
- Designed interactive visualizations using Power BI/Tableau.
- Key visuals include:
  - Most popular categories by views
  - Sentiment distribution
  - Trending duration heatmaps
  - Region-wise performance comparisons

---

## 📦 Deliverables

- 📓 `youtube_analysis_guide.ipynb`: Jupyter Notebook with full analysis
- 📁 `README.md`: This project summary
- 📈 Power BI dashboard (optional extension)
- 📊 Visuals for time series, category ranking, and sentiments

---

## 🌍 Notes

- Initial analysis done using `INvideos.csv` (India trending data)
- Extendable: Just clean and append other countries' datasets using the same structure
- Categories can be mapped using the `category_id` reference JSON from YouTube API

---

## 🔁 Future Enhancements

- Include more regions like US, GB, DE, etc.
- Add natural language processing on video descriptions
- Predict trending potential of new videos using regression models
