# Food Costs - Grocery Expense Tracker

A modern, responsive Rails application for tracking grocery purchases, managing food costs, and planning meals. Built with Ruby on Rails 8, Bootstrap 5, and Devise authentication.

## 🚀 Features

### Store Management

- Add grocery stores with a name, address/location, and logo image
- Store logo uploaded via Active Storage with automatic image variants
- Each store card shows total dollars spent at a glance
- View all purchases grouped by date per store

### Product Management

- Add, edit, and delete grocery products with full detail:
  - Product name, store, quantity, unit, unit price, purchase date
  - Total cost calculated automatically (quantity × unit price)
- Supports negative values for discounts and vouchers
- Session memory remembers last used store and date for fast repeat entry
- Autocomplete product name field pre-fills unit, price, and store from previous purchases
- Filter products by name (dropdown), store, and purchase date
- Export product list to CSV or print directly from the browser

### Shopping Reports

- Week-to-date, month-to-date, and year-to-date spending totals
- Totals are based on product purchase dates (not entry dates)
- Filter totals by product name, store, or purchase date
- Export report summary to CSV or print

### Product Price History

- Select any product to view its full purchase history across all stores
- Price change indicators (▲ up / ▼ down) between purchases
- Group history by all purchases, monthly, or yearly
- Shows highest, lowest, and average unit price per period

### Recipes

- Create and manage recipes with ingredients, instructions, and nutritional info
- Filter by cuisine, difficulty, occasion, and dietary tags
- Track prep time, cook time, servings, and detailed macros/micronutrients

### Menus

- Plan meals by creating menus with occasion, date, and cuisine
- Add recipes to a menu and organise by course (starter, main, dessert, etc.)
- Filter and browse menus by occasion and date

### User Experience

- Secure per-user data — stores, products, recipes, and menus are all private
- Fully responsive design for desktop, tablet, and mobile
- Bootstrap 5 with custom pastel styling
- Pagination on all list views

## 🛠️ Technology Stack

- **Backend**: Ruby on Rails 8.0
- **Database**: PostgreSQL (production), SQLite3 (development)
- **Frontend**: Bootstrap 5, Hotwire/Turbo
- **Authentication**: Devise
- **File Storage**: Active Storage (local in development, configurable for cloud)
- **Image Processing**: mini_magick (Windows) / vips (Linux/Mac)
- **JavaScript**: Importmaps (no bundler required)
- **Deployment**: Render / Railway / Kamal

## 📋 Prerequisites

- Ruby 3.4.0 or higher
- Rails 8.0 or higher
- PostgreSQL (production) or SQLite3 (development)
- ImageMagick (Windows) or libvips (Linux/Mac) for image processing

## 🚀 Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/pmnoos/food-costs.git
   cd food-costs
   ```

2. **Install dependencies**

   ```bash
   bundle install
   ```

3. **Set up the database**

   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Start the development server**

   ```bash
   bin/dev
   ```

5. **Visit the application**

   Open your browser and go to `http://localhost:3000`

## 📱 Usage

### Getting Started

1. **Register an account** or sign in
2. **Add your stores** — each store can have a name, address, and logo
3. **Add products** as you shop, including store, quantity, unit price, and purchase date
4. **View reports** to see your week, month, and year spending totals
5. **Track price history** for any product across all stores over time

## 🗄️ Database Schema

### Products Table

- `name`, `quantity`, `unit`, `unit_price`, `total_cost`, `purchase_date`, `store_id`

### Stores Table

- `name`, `location`, `user_id` + Active Storage logo attachment

### Recipes Table

- `name`, `cuisine`, `difficulty`, `occasion`, `prep_time`, `cook_time`, `servings`
- `ingredients`, `instructions`, `notes`
- Full nutritional fields: calories, protein, carbs, fat, sodium, etc.

### Menus Table

- `name`, `occasion`, `date`, `cuisine`, `servings`, `description`, `user_id`
- Many-to-many with recipes via `menu_recipes` (includes course and position)

### Users Table

- Standard Devise user model with email/password authentication

## 🧪 Testing

```bash
rails test
rails test:system
```

## 🚀 Deployment

### Render / Railway

The repository includes `render.yaml` and `railway.json` for one-click deployment to Render or Railway.

### Image processing on server (Active Storage)

The app auto-selects the image processor by platform:

- Windows: `mini_magick` (requires ImageMagick)
- Linux/Mac servers: `vips` (requires libvips)

Override with environment variable if needed:

```bash
ACTIVE_STORAGE_VARIANT_PROCESSOR=mini_magick
ACTIVE_STORAGE_VARIANT_PROCESSOR=vips
```

### Kamal (Docker)

```bash
kamal deploy
```

## 📄 License

This project is licensed under the MIT License.

## 🙏 Acknowledgments

- [Ruby on Rails](https://rubyonrails.org/)
- [Bootstrap](https://getbootstrap.com/)
- [Devise](https://github.com/heartcombo/devise)
- [Active Storage](https://guides.rubyonrails.org/active_storage_overview.html)

---

Happy grocery tracking.
