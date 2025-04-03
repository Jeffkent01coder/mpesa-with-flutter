# MPESA-WITH-FLUTTER

Empowering seamless payments, transforming user experience

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![M-Pesa](https://img.shields.io/badge/M--Pesa-00FF00?style=for-the-badge&logoColor=white)

---

## Table of Contents

- [Overview](#overview)
- [Why M-Pesa with Flutter](#why-m-pesa-with-flutter)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Code Implementation](#code-implementation)
  - [MpesaDataSourceImpl (mpesa_data_source.dart)](#mpesadatasourceimpl-mpesa_data_sourcedart)
  - [PaymentProvider (payment_provider.dart)](#paymentprovider-payment_providerdart)
  - [ProcessPaymentUseCase (process_payment_usecase.dart)](#processpaymentusecase-process_payment_usecasedart)
  - [PaymentRepository (payment_repository.dart)](#paymentrepository-payment_repositorydart)
  - [PaymentPage (payment_page.dart)](#paymentpage-payment_pagedart)
  - [PaymentRepositoryImpl (payment_repository_impl.dart)](#paymentrepositoryimpl-payment_repository_impldart)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgements](#acknowledgements)

---

## Overview

`MPESA-WITH-FLUTTER` is a Flutter-based mobile application designed to integrate M-Pesa payment services seamlessly into your app. This project provides a robust solution for developers to implement STK Push payments, query transaction statuses, and handle callbacks efficiently. Built with Flutter, it ensures cross-platform compatibility for both Android and iOS, offering a smooth and secure payment experience for users.

---

## Why M-Pesa with Flutter?

This project empowers developers to create robust mobile applications that leverage M-Pesa's powerful payment infrastructure. Here’s why you should consider using this project:

- **Cross-Platform Compatibility**: Build applications for Android, iOS, and more with a single codebase using Flutter.
- **Seamless Integration**: Easily integrate M-Pesa STK Push payments with minimal setup.
- **Real-Time Transaction Status**: Query transaction statuses and handle success/failure callbacks efficiently.
- **Secure and Reliable**: Implements best practices for secure API calls and credential management.
- **Developer-Friendly**: Well-documented code with a clean architecture for easy customization.

---

## Getting Started

### Prerequisites

Before you begin, ensure you have the following:

- **Flutter SDK**: Version 3.0.0 or higher
- **Dart**: Version 2.17.0 or higher
- **M-Pesa API Credentials**:
  - Consumer Key
  - Consumer Secret
  - Passkey
  - Business Shortcode
- **Development Environment**:
  - Android Studio or VS Code
  - Android/iOS emulator or physical device
- **Dependencies**:
  - `http` package for API calls
  - `provider` for state management
  - `get_it` for dependency injection

### Installation

Follow these steps to set up the project locally:

1. **Clone the Repository**

   ```bash
   git clone https://github.com/your-username/mpesa-with-flutter.git

2. **Navigate to the Project Directory**

   ```bash
   cd mpesa-with-flutter

3. **Install Dependencies**

   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     http: ^0.13.5
     provider: ^6.0.0
      get_it: ^7.2.0
   then run :
     flutter pub get

4. **Configure M-Pesa Credentials**

   ```dart
   static const String _consumerKey = "your_consumer_key";
   static const String _consumerSecret = "your_consumer_secret";
   static const String _passKey = "your_passkey";
   static const String _businessShortCode = "your_shortcode";
5. **Run the App**
    ```bash
   flutter run
    
6. **Testing the App**
   1.  Unit Tests
   Test the MpesaDataSourceImpl for access token generation and API calls.
   Test the ProcessPaymentUseCase for input validation.
   
    ```bash
   flutter test test/

  2. Integration Tests

    Test the full payment flow using a sandbox environment.
    Verify transaction status updates and UI feedback.
3. Manual Testing

     Use the M-Pesa sandbox to simulate payments.
     Test with different phone numbers and amounts.
     Verify error handling for failed transactions.

## Contributing

Contributions are welcome! Here's how you can contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature`).
3. Make your changes and commit (`git commit -m "Add your feature"`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a Pull Request.

Please ensure your code follows the project's coding style and includes tests where applicable.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [Flutter](https://flutter.dev/) - For the amazing cross-platform framework.
- [M-Pesa](https://www.safaricom.co.ke/business/m-pesa) - For providing the payment API.
- [Safaricom Developer Portal](https://developer.safaricom.co.ke/) - For the sandbox environment and documentation.
- Contributors and the open-source community.

*Happy coding! If you encounter any issues, feel free to open an issue on GitHub.*

   
