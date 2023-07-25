import 'package:flutter/material.dart';

bool isStrongPassword(String password) {
    if (password.length < 8) {
      return false;
    }

    RegExp uppercaseRegex = RegExp(r'[A-Z]');
    RegExp lowercaseRegex = RegExp(r'[a-z]');
    RegExp digitRegex = RegExp(r'[0-9]');
    RegExp specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (!uppercaseRegex.hasMatch(password)) {
      return false;
    }

    if (!lowercaseRegex.hasMatch(password)) {
      return false;
    }

    if (!digitRegex.hasMatch(password)) {
      return false;
    }

    if (!specialCharRegex.hasMatch(password)) {
      return false;
    }

    return true;
  }

  IconData getIconForPasswordStrength(String password) {
    return isStrongPassword(password)
        ? Icons.sentiment_satisfied
        : Icons.sentiment_dissatisfied;
  }