require 'minitest/autorun'
require 'sqlite3'
# Início da prova Integrada - Compõe nota da P3

class TestExercicio < Minitest::Test

  def test_db_sacole
    db = SQLite3::Database.open 'sacole.db'
    db.results_as_hash = true

    db.execute 'DROP TABLE IF EXISTS littleshop'
    db.execute 'DROP TABLE IF EXISTS sacoles'
    db.execute 'DROP TABLE IF EXISTS storage'

    # littleshops
    db.execute 'CREATE TABLE littleshop(littleshop_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)'
    db.execute 'INSERT INTO littleshop VALUES(?, ?)', 01, 'test'

    # sacoles
    db.execute 'CREATE TABLE sacoles(sacoles_id INTEGER PRIMARY KEY AUTOINCREMENT, flavor TEXT, value REAL)'
    db.execute 'INSERT INTO sacoles VALUES(?, ?, ?)', 01, 'morango', 2.4

    # storage
    db.execute 'CREATE TABLE storage (
      storage_id INTEGER PRIMARY KEY AUTOINCREMENT,
      littleshop_id INTEGER,
      sacoles_id INTEGER,
      sold BOOLEAN NOT NULL,
      FOREIGN KEY (littleshop_id)
      REFERENCES littleshop(littleshop_id),
      FOREIGN KEY (sacoles_id)
      REFERENCES sacoles(sacoles_id))'
    db.execute 'INSERT INTO storage(littleshop_id, sacoles_id, sold) VALUES(?, ?, ?)', 1, 2, 0

    resultStorage = db.execute 'SELECT * FROM storage'
    puts resultStorage
    
    resultQlittleshop = db.execute 'SELECT * FROM littleshop WHERE littleshop_id=?', 01
    expected_result_littleshop = [
      {
        'littleshop_id' => 01,
        'name' => 'test'
      }
    ]
    assert_equal resultQlittleshop, expected_result_littleshop 

    resultQsacoles = db.execute 'SELECT * FROM sacoles WHERE sacoles_id=?', 01
    expected_result_sacoles = [
      {
        'sacoles_id' => 01,
        'flavor' => 'morango',
        'value' => 2.4
      }
    ]
    assert_equal resultQsacoles, expected_result_sacoles 

    # resutlQstorage = db.execute 'SELECT ID, littleshop_id, sacole_id, sold FROM storage WHERE mercadinho_id=?', 01
    # expected_result_storage = [
    #   {
    #     'ID' => 01,
    #     'littleshop_id' => 01,
    #     'sacole_id' => 01, 
    #     'sold' => false
    #   }
    # ]
    # assert_equal resutlQstorage, expected_result_storage
  end


  # Criar uma tabela 'sacoles' com as seguintes colunas:
  # 1. id => Int
  # 3. sabor => String
  # 4. valor => Float
  #
  # Ex.:
  # id | sabor    | valor |
  # 21 |  morango | 1.0   |
  # 22 |  limao   | 0.5   |
  # 23 |  pitanga | 1.0   |
  #
  # Criar uma tabela 'estoques' com as seguintes colunas:
  # 1. id => Int
  # 2. mercadinho_id => Int
  # 3. sacole_id => Int
  # 4. vendido => Boolean
  #
  # Ex.:
  # id | mercadinho_id | sacole_id | vendido |
  # 11 |  1            | 21         | false   |
  # 12 |  1            | 21         | false   |
  # 13 |  1            | 22         | false   |
  # 14 |  1            | 23         | false   |
  # 15 |  1            | 23         | false   |
  # 16 |  1            | 23         | false   |
  #
  # Criar uma tabela 'mercadinhos' com as seguintes colunas:
  # 1. id => Int
  # 2. nome => String
  #
  # Ex.:
  # id | nome |
  # 1  | Mercadinho Rachid |
  #
  # Teste obrigatório:
  # 1. Fazer query que retorne total que o mercadinho faturou a partir das seguintes vendas:
  #
  # - Venda de um sacolé do sabor morando no valor de R$ 1,00
  # - Venda de um sacolé do sabor limão no valor de R$ 0,50
  # - Venda de dois sacolés do sabor pitanga no valor de R$ 2,00
  #
  # Dicas:
  # 1. User CREATE TABLE para criar os bancos: mercadinhos, sacoles, estoques
  # 2. Usar SELECT com WHERE para filtrar
  # 3. Usar UPDATE com WHERE para atualizar o dado correto do banco
  # 4. Usar INSERT para criar os sacolés, estoque e o mercadinho
end
