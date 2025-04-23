 <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Luxe Essence | Premium Perfumes</title>
    <style>
        /* Global Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Cormorant Garamond', 'Times New Roman', serif;
        }

        body {
            background-color: #f8f8f8;
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Enhanced Header Styles */
        header {
            background-color: #fff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 100;
            border-bottom: 1px solid rgba(166, 124, 82, 0.2);
        }

        .header-top {
            background-color: #1a1a1a;
            color: #fff;
            text-align: center;
            padding: 8px 0;
            font-size: 12px;
            letter-spacing: 1px;
        }

        .header-inner {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 25px 0;
        }

        .logo-container {
            display: flex;
            align-items: center;
        }

        .logo {
            font-size: 26px;
            font-weight: 400;
            letter-spacing: .25em;
            color: #111;
            text-decoration: none;
            position: relative;
        }

        .logo::after {
            content: '';
            position: absolute;
            bottom: -6px;
            left: 0;
            width: 40px;
            height: 1px;
            background-color: #a67c52;
        }

        .logo-tagline {
            display: block;
            font-size: 12px;
            color: #999;
            letter-spacing: 3px;
            margin-top: 5px;
        }

        nav {
            display: flex;
            align-items: center;
        }

        .nav-links {
            display: flex;
            list-style: none;
        }

        .nav-links li {
            margin-right: 35px;
            position: relative;
        }

        .nav-links a {
            text-decoration: none;
            color: #333;
            font-size: 14px;
            letter-spacing: 2px;
            text-transform: uppercase;
            transition: color 0.3s ease;
            display: inline-block;
            padding: 5px 0;
        }

        .nav-links a::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 1px;
            background-color: #a67c52;
            transition: width 0.3s ease;
        }

        .nav-links a:hover {
            color: #a67c52;
        }

        .nav-links a:hover::after {
            width: 100%;
        }

        .cart-button {
            background-color: transparent;
            color: #333;
            border: 1px solid #a67c52;
            padding: 10px 22px;
            border-radius: 0;
            cursor: pointer;
            font-size: 13px;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
        }

        .cart-button:hover {
            background-color: #a67c52;
            color: white;
        }

        .cart-icon {
            margin-right: 8px;
            font-size: 16px;
        }

        /* Main Content */
        main {
            margin-top: 190px;
            margin-bottom: 60px;
        }

        .hero {
            text-align: center;
            margin-bottom: 60px;
        }

        .hero h1 {
            font-size: 42px;
            font-weight: 400;
            margin-bottom: 20px;
            color: #222;
        }

        .hero p {
            font-size: 18px;
            color: #666;
            max-width: 600px;
            margin: 0 auto;
        }

        .perfume-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 30px;
        }

        .perfume-item {
            background: white;
            border-radius: 0;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
            display: block;
        }

        .perfume-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .perfume-image {
            height: 300px;
            width: 100%;
            background-color: #f0f0f0;
            background-size: cover;
            background-position: center;
        }

        .perfume-info {
            padding: 20px;
        }

        .perfume-name {
            font-size: 18px;
            font-weight: 500;
            margin-bottom: 10px;
            color: #222;
        }

        .perfume-price {
            font-size: 16px;
            color: #a67c52;
            font-weight: 500;
        }

        /* Footer */
        footer {
            background-color: #222;
            color: #f8f8f8;
            padding: 60px 0 20px;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 30px;
            margin-bottom: 40px;
        }

        .footer-column h3 {
            font-size: 18px;
            font-weight: 500;
            margin-bottom: 20px;
            letter-spacing: 1px;
        }

        .footer-column ul {
            list-style: none;
        }

        .footer-column ul li {
            margin-bottom: 10px;
        }

        .footer-column a {
            color: #ccc;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-column a:hover {
            color: #a67c52;
        }

        .social-links {
            display: flex;
            gap: 15px;
        }

        .social-icon {
            color: #ccc;
            font-size: 20px;
            transition: color 0.3s ease;
        }

        .social-icon:hover {
            color: #a67c52;
        }

        .newsletter-form {
            display: flex;
            margin-top: 15px;
        }

        .newsletter-input {
            flex-grow: 1;
            padding: 10px;
            border: none;
            border-radius: 0;
            background-color: #333;
            color: #fff;
        }

        .newsletter-button {
            background-color: #a67c52;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 0;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .newsletter-button:hover {
            background-color: #8a6642;
        }

        .footer-bottom {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid #444;
            font-size: 14px;
            color: #888;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .perfume-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .footer-content {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }
            
            .perfume-grid {
                grid-template-columns: 1fr;
            }
            
            .footer-content {
                grid-template-columns: 1fr;
            }
        }
    </style>
    //use include to add to each file yaa