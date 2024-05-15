enum EFlavor { dev, prod }

class Environment {
  static EFlavor flavor = EFlavor.dev;

  static String baseUrlV2() {
    switch (flavor) {
      case EFlavor.dev:
        return 'https://newsapi.org/v2';
      case EFlavor.prod:
        return 'https://newsapi.org/v2';
      default:
        return 'https://newsapi.org/v2';
    }
  }

  static String keyNewsApi() {
    switch (flavor) {
      case EFlavor.dev:
        return '6dbfddfc87c64d7e8188e45b1b450b8a';
      case EFlavor.prod:
        return '6dbfddfc87c64d7e8188e45b1b450b8a';
      default:
        return '6dbfddfc87c64d7e8188e45b1b450b8a';
    }
  }
}
