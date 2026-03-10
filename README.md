# Retail Rocket E-commerce Funnel Analysis

**Tools:** SQL · Databricks SQL Editor · Looker Studio  
**Dataset:** Retail Rocket E-commerce Events — 2.7M behavioral events, 1.4M visitors  
**Tables:** events · item_properties · category_tree

---

## Overview

Full funnel analysis on 2.7M Retail Rocket clickstream events — views, add-to-carts, and purchases across 1.4M visitors. Used SQL to segment visitor behavior, calculate conversion rates at each funnel stage, identify top performing products, and analyze hourly activity patterns. Built an interactive dashboard in Looker Studio to visualize findings.

---

## Dataset Schema

| Table | Description |
|---|---|
| `events` | 2.7M rows — every user action: view, addtocart, transaction |
| `item_properties` | Product properties — price, category |
| `category_tree` | Product category hierarchy |

**Event types:**
- `view` — user viewed a product page
- `addtocart` — user added item to cart
- `transaction` — purchase completed

---

## Dashboard

<img width="554" height="308" alt="image" src="https://github.com/user-attachments/assets/c203ee5d-9475-482d-a1af-45ea85833285" />

---

## Analysis & Findings

### 1. Overall Funnel Conversion
> **Business Q:** Where do users drop off in the purchase journey?

| Metric | Value |
|---|---|
| Visitors who viewed | 1,404,179 |
| Visitors who added to cart | 37,722 |
| Visitors who purchased | 11,719 |
| View → Cart conversion | 2.7% |
| Cart → Purchase conversion | 31.1% |
| Overall conversion rate | 0.8% |

**Insight:** The biggest drop-off is at the first step — 97.3% of viewers never add anything to cart. However once a user adds to cart, 31.1% complete a purchase — high intent signal. The priority should be improving view-to-cart conversion.

---

### 2. Event Breakdown
> **Business Q:** What is the split of user actions?

| Event | Total Events | Unique Visitors | Share |
|-------|-------------|-----------------|-------|
| View | 2,664,312 | 1,404,179 | 96.7% |
| Add to Cart | 69,332 | 37,722 | 2.5% |
| Transaction | 22,457 | 11,719 | 0.8% |

**Insight:** 96.7% of all events are views — the platform is heavily browse-driven with very few users taking action beyond viewing.

---

### 3. Top 10 Most Viewed Items

| Item ID | Views | Add to Carts | Purchases | View to Cart % |
|---------|-------|-------------|-----------|----------------|
| 187946 | 3,410 | 2 | 0 | 0.1% |
| 461686 | 2,539 | 306 | 133 | 12.1% |
| 5411 | 2,325 | 9 | 0 | 0.4% |
| 370653 | 1,854 | 0 | 0 | 0.0% |
| 219512 | 1,740 | 48 | 12 | 2.8% |

**Insight:** Item 461686 stands out with a 12.1% view-to-cart rate vs most items under 1% — a strong product-market fit signal worth investigating for merchandising strategy.

---

### 4. Visitor Behavior Segmentation

| Segment | Visitors | % of Total |
|---------|---------|------------|
| Viewer Only | 1,368,715 | 97.2% |
| Cart Abandoner | 27,146 | 1.9% |
| Converted (Purchased) | 11,719 | 0.8% |

**Insight:** 97.2% of visitors never interact beyond browsing. Cart abandoners (1.9%) represent a high-value retargeting opportunity — they showed purchase intent but didn't complete.

---

### 5. Hourly Activity Pattern
**Insight:** Activity peaks in the evening hours (8–10 PM) and is lowest in early morning (4–6 AM) — suggesting evening is the best time for promotions and email campaigns.

---

## Technical Highlights

- Analyzed **2.7M clickstream events** using conditional aggregation (`COUNT CASE WHEN`) to compute conversion rates across funnel stages
- Built **visitor behavior segmentation** using nested subquery with MAX aggregation to classify each visitor by their highest funnel stage reached
- Used **window functions** (`SUM() OVER()`) for event share percentage calculation
- Identified **product-level conversion anomalies** by comparing view-to-cart rates across top items
- Built **interactive Looker Studio dashboard** with pie chart, bar chart, line chart and KPI scorecards

---

## How to Reproduce

1. Download dataset from [Kaggle](https://www.kaggle.com/datasets/retailrocket/ecommerce-dataset)
2. Upload CSVs to Databricks via **Data → Add or upload data**
3. Run queries from `retail_rocket_queries.sql` in **Databricks SQL Editor**
4. Download results as CSVs and upload to [Looker Studio](https://lookerstudio.google.com)
