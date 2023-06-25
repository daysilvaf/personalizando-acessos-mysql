-- Trigger de remoção (Before Delete):

CREATE TRIGGER before_delete_trigger
BEFORE DELETE ON tabela
FOR EACH ROW
BEGIN

-- Ação a ser executada antes da remoção dos dados
-- Exemplo:
-- Atualizar o estoque após a remoção de um produto do carrinho de compras

UPDATE estoque
SET quantidade = quantidade + 1
WHERE produto_id = OLD.produto_id;
END;

-- Trigger de atualização (Before Update):

CREATE TRIGGER before_update_trigger
BEFORE UPDATE ON tabela
FOR EACH ROW
BEGIN

-- Ação a ser executada antes da atualização dos dados
-- Exemplo:
-- Verificar se o novo valor do campo "status" é válido antes de atualizar um pedido

IF NEW.status NOT IN ('pendente', 'processando', 'entregue') THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Status inválido';
END IF;
END;

-- Gatilho (trigger) "before delete"

CREATE TRIGGER before_delete_user_trigger
BEFORE DELETE ON users
FOR EACH ROW
BEGIN

-- Inserir os dados do usuário sendo excluído em uma tabela de backup

INSERT INTO users_backup (id, username, email, deleted_at)
VALUES (OLD.id, OLD.username, OLD.email, NOW());
END;

-- Atualização

CREATE TRIGGER after_insert_employee_trigger
AFTER INSERT ON employees
FOR EACH ROW
BEGIN 

-- Verificar se o novo colaborador tem um salário base definido

IF NEW.base_salary IS NULL THEN

-- Definir um salário base padrão para o colaborador

SET NEW.base_salary = 5000;

-- salário base padrão de 5000

END IF;
END;
