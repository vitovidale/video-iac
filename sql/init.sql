-- sql/init.sql

-- Cria a tabela para usuários no user-auth-service
-- Protegido por usuário e senha
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL, -- Armazene hashes de senha, nunca senhas em texto puro!
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Opcional: Adiciona um usuário padrão para testes rápidos
-- Em produção, isso seria gerenciado de outra forma
-- IMPORTANTE: Substitua o hash abaixo por um hash bcrypt REAL da senha 'admin'!
-- Você pode gerar um hash bcrypt em Go facilmente com golang.org/x/crypto/bcrypt
-- Exemplo de como gerar em Go:
-- package main
-- import "golang.org/x/crypto/bcrypt"
-- import "fmt"
-- func main() {
--     password := "admin"
--     hashedPassword, _ := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
--     fmt.Println(string(hashedPassword))
-- }
-- Execute isso localmente para obter o hash e cole-o aqui.
INSERT INTO users (username, password_hash, email)
VALUES ('admin', '$2a$10$C8q.f3x.N7.z5Y3z9.z3Y.O2m.d.S.r.F.P.g.H.j.K.L.M.n.o.p.q.r.s.t.u.v.w.x.y.z.', 'admin@fiapx.com')
ON CONFLICT (username) DO NOTHING;


-- Cria a tabela para status dos vídeos no video-processor-service
-- Listagem de status dos vídeos de um usuário
CREATE TABLE IF NOT EXISTS video_processing_statuses (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL, -- FK para a tabela users
    video_original_filename VARCHAR(255) NOT NULL,
    status VARCHAR(50) NOT NULL, -- Ex: 'PENDING', 'PROCESSING', 'COMPLETED', 'FAILED'
    processed_file_path VARCHAR(255), -- Caminho para o arquivo .zip resultante
    error_message TEXT, -- Mensagem de erro se o processamento falhar
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Atualiza a coluna updated_at automaticamente (exemplo para PostgreSQL)
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_video_processing_statuses_updated_at ON video_processing_statuses;
CREATE TRIGGER update_video_processing_statuses_updated_at
BEFORE UPDATE ON video_processing_statuses
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();