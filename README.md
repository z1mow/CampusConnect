# Campus Connect

## Kurulum

1. Projeyi klonlayın:
```bash
git clone [repo-url]
cd campus_connect
```

2. Gerekli gem'leri yükleyin:
```bash
bundle install
```

3. Veritabanını kurun:
```bash
bin/setup_db.sh
```

## Veritabanı Yönetimi

### Materyalleştirilmiş Görünümleri Güncelleme

Grup mesaj özetlerini güncellemek için aşağıdaki komutu çalıştırın:

```bash
bin/rails views:refresh_group_messages
```

## Geliştirme

[Diğer geliştirme talimatları...]
