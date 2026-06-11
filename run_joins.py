import os
import sqlite3


def run_joins_test():
    # Абсолютний шлях до бази даних
    db_path = r"E:\PyCharm\pythonproject30\my_sqlite_project\hr.db"
    script_path = "task1.sql"

    if not os.path.exists(db_path):
        print(f"Помилка: Базу даних не знайдено за шляхом {db_path}!")
        return

    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    # Наші SQL-запити
    with open(script_path, "r", encoding="utf-8") as f:
        sql_content = f.read()

    # Розділяємо запити за крапкою з комою
    queries = [q.strip() for q in sql_content.split(";") if q.strip()]

    print(f"Успішно завантажено {len(queries)} запитів із файлу {script_path}.\n")

    for index, query in enumerate(queries, 1):
        print(f"=== ВИКОНАННЯ ЗАПИТУ №{index} ===")

        try:
            cursor.execute(query)

            # Отримуємо імена колонок результату
            titles = [desc[0] for desc in cursor.description]
            print(f"Колонки: {titles}")

            # Беремо перші 3 рядки для демонстрації
            rows = cursor.fetchmany(3)
            if not rows:
                print("[Результат порожній]")
            for row in rows:
                print(row)

            # Перевіримо загальну кількість рядків, які повернув запит
            remaining = cursor.fetchall()
            total_rows = len(rows) + len(remaining)
            if remaining:
                print(f"... (показано 3 з {total_rows} рядків) ...")

        except sqlite3.Error as e:
            print(f"Помилка в запиті №{index}: {e}")

        print("-" * 60 + "\n")

    conn.close()


if __name__ == "__main__":
    run_joins_test()