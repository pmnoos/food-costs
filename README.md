# Food Costs - Grocery Expense Tracker

A modern, responsive Rails application for tracking grocery purchases and managing food costs. Built with Ruby on Rails 7, Tailwind CSS, and Devise authentication.

## 🚀 Features

### Core Functionality
- **Product Management**: Add, edit, and delete grocery items with detailed information
- **Store Management**: Organize purchases by different grocery stores
- **Purchase Tracking**: Track purchase dates and categorize spending by time periods
- **Cost Calculations**: Automatic total cost calculation (quantity × unit price)
- **Voucher Support**: Handle discounts and vouchers with negative values
- **Filtering & Search**: Filter products by store and purchase date
- **Responsive Design**: Mobile-first design that works on all devices

### User Experience
- **Modern UI**: Clean, intuitive interface built with Tailwind CSS
- **Quick Add Workflow**: Streamlined process for adding multiple products
- **Session Memory**: Remembers last used store and date for quick entry
- **Grouped Views**: Products grouped by purchase date for better organization
- **Real-time Calculations**: Dynamic total cost updates as you type

### Technical Features
- **Authentication**: Secure user registration and login with Devise
- **Responsive Design**: Mobile-optimized with custom media queries
- **RESTful API**: JSON endpoints for all resources
- **Database Migrations**: Proper schema management
- **Testing Framework**: Comprehensive test suite included

## 🛠️ Technology Stack

- **Backend**: Ruby on Rails 7.1
- **Database**: SQLite (development), PostgreSQL (production ready)
- **Frontend**: Tailwind CSS, Hotwire/Turbo
- **Authentication**: Devise
- **JavaScript**: Importmaps (no bundler required)
- **Deployment**: Kamal (Docker-based deployment)

## 📋 Prerequisites

- Ruby 3.4.0 or higher
- Rails 7.1 or higher
- SQLite3 (for development)
- Node.js (for Tailwind CSS compilation)

## 🚀 Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/food-costs.git
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
1. **Register an account** or sign in if you already have one
2. **Add stores** where you shop for groceries
3. **Start adding products** with their details:
   - Product name
   - Store
   - Quantity and unit
   - Unit price
   - Purchase date

### Key Features
- **Quick Add**: Use the "Quick Add" button to pre-fill forms with current filters
- **Filtering**: Filter products by store and purchase date
- **Vouchers**: Enter negative values for discounts and vouchers
- **Multi-add Workflow**: After creating a product, you're returned to the form for quick addition of more items

### Mobile Experience
- Fully responsive design optimized for mobile devices
- Touch-friendly interface with appropriate button sizes
- Stacked layouts on small screens for better usability

## 🗄️ Database Schema

### Products
- `name`: Product name
- `quantity`: Amount purchased
- `unit`: Unit of measurement (kg, pkt, each, etc.)
- `unit_price`: Price per unit
- `total_cost`: Calculated total (quantity × unit_price)
- `purchase_date`: Date of purchase
- `store_id`: Reference to store

### Stores
- `name`: Store name
- `location`: Store location (optional)

### Users
- Standard Devise user model with email authentication

## 🧪 Testing

Run the test suite:
```bash
rails test
```

Run system tests:
```bash
rails test:system
```

## 🚀 Deployment

This application is configured for deployment with Kamal:

1. **Set up your server** with Docker
2. **Configure environment variables** in `.kamal/secrets`
3. **Deploy**:
   ```bash
   kamal deploy
   ```

### Image processing on server (Active Storage)

- The app auto-selects image processor by platform:
  - Windows: `mini_magick`
  - Non-Windows servers: `vips`
- You can force either one with env var:
  - `ACTIVE_STORAGE_VARIANT_PROCESSOR=mini_magick`
  - `ACTIVE_STORAGE_VARIANT_PROCESSOR=vips`
- Server package requirements:
  - `mini_magick`: ImageMagick installed
  - `vips`: libvips installed

## 🎨 Customization

### Styling
- Modify `app/assets/stylesheets/application.css` for custom styles
- Tailwind CSS classes are used throughout the application
- Responsive breakpoints: `sm:` (640px+), `md:` (768px+), `lg:` (1024px+)

### Adding Features
- Controllers follow Rails conventions
- Views use ERB templates with Tailwind CSS
- Models include proper validations and callbacks

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with [Ruby on Rails](https://rubyonrails.org/)
- Styled with [Tailwind CSS](https://tailwindcss.com/)
- Authentication by [Devise](https://github.com/heartcombo/devise)
- Deployment with [Kamal](https://kamal-deploy.org/)

## 📞 Support

If you encounter any issues or have questions:
1. Check the [Issues](https://github.com/yourusername/food-costs/issues) page
2. Create a new issue with detailed information
3. Include your Ruby version, Rails version, and any error messages

---

**Happy grocery tracking! 🛒💰**
