/* Cria o Banco de Dados */
create database Bd_Consultorio;

/* Seleciona o Banco de Dados */
use Bd_Consultorio;

/* Apaga o Banco de Dados */
drop database Bd_Consultorio;

/* Apaga a tabela do Banco de Dados */
drop table tb_Paciente;

/* exibe a estrutura da tabela */
describe tb_Paciente;

/* Tabela Paciente */
CREATE TABLE Tb_Paciente(
Id_Paciente int auto_increment not null, /* chave primária */
Nome_Paciente varchar(100) not null, /* aceita letras, números e caracteres especiais */
Email_Paciente varchar(100) not null,
Telefone_Paciente varchar(20) not null,
Endereco_Paciente varchar(50) not null,
Data_Nascimento_Paciente date not null, /* segue o modelo americano ano/mes/dia */
Genero_Paciente enum('Masculino', 'Feminino', 'Nao-Binario', 'Trans') not null, /* Campo aceita valores pré determinados */
Cpf_Paciente varchar(14) not null,
RG_Paciente varchar(15) not null,
constraint Pk_Id_Paciente primary key (Id_Paciente)
);

CREATE TABLE Tb_Medico(
Id_Medico int auto_increment not null, /* chave primária */
Nome_Medico varchar(100) not null, /* aceita letras, números e caracteres especiais */
Data_Nascimento_Medico varchar(100) not null,
Genero_Medico enum('Masculino', 'Feminino', 'Nao-Binario', 'Trans') not null, 
CRM_Medico varchar(13) not null,
Especialidade_Medico varchar(50) not null,
Turno_Medico varchar (20) not null,
constraint Pk_Id_Medico primary key (Id_Medico)
);

CREATE TABLE Tb_Consulta(
Id_Consulta int auto_increment not null, /* chave primária */
Data_Consulta date not null, 
Hora_Consulta datetime not null,
Fk_Id_Paciente varchar(1) not null,
Fk_Id_Medico varchar(1) not null,
constraint Pk_Id_Consulta primary key (Id_Consulta),

constraint Fk_Id_Paciente foreign key (Fk_Id_Paciente)
references Tb_Paciente(Id_Paciente),

constraint Fk_Id_Medico foreign key (Fk_Id_Medico)
references Tb_Medico(Id_Medico)
);

/* inserindo dados nos campos da tabela */
insert into tb_Paciente(Nome_Paciente, Data_Nascimento_Paciente, Genero_Paciente, Cpf_Paciente) value
('Roberto Carlos', '1941-04-19', 'Masculino', '999.999.999-99'),
('MaTuê', '1993-10-11', 'Masculino', '888.888.888-63'),
('Pedro Paulo', '1970-04-22', 'Masculino', '666.666.666-66'),
('Clarice Lispector', '1920-12-10', 'Feminino', '222.222.222-22'),
('Senor Abravanel', '1930-12-12', 'Masculino', '777.777.777-77');

insert into tb_Medico(Nome_Medico, Data_Nascimento_Medico, Genero_Medico, CRM_Medico, Especialidade_Medico, Turno_Medico) value
('Dr. João Silva', '1941-04-19', 'Masculino', 'CRM-SP 123456', 'Cardiologista', 'Diurno'),
('Dra. Maria Oliveira', '1993-10-11', 'Feminino', 'CRM-RJ 654321', 'Dermatologista', 'Noturno'),
('Dr. Carlos Pereira', '1970-04-22', 'Masculino', 'CRM-MG 112233', 'Pediatra', 'Diurno'),
('Dra. Ana Costa', '1920-12-10', 'Feminino', 'CRM-BA 445566', 'Ortopedista', 'Noturno'),
('Dr. Pedro Fernandes', '1930-12-12', 'Masculino', 'CRM-PR 778899', 'Ginecologista', 'Vespertino');

insert into tb_Consulta(Data_Consulta, Hora_Consulta, Fk_Id_Paciente, Fk_Id_Medico) value
('2024-05-17', '14:30:00', '1', '1'),
('2024-06-01', '09:00:00', '2', '1'),
('2024-06-15', '11:45:00', '3', '1'),
('2024-07-01', '16:00:00', '4', '1'),
('2024-07-20', '10:15:00', '1', '2');

/* exibe os dados inseridos na tabela */
select * from tb_Consulta;

/* comando para exibir somente o campo atributo especificado */
select Nome_Paciente, Data_Nascimento_Paciente from tb_Paciente;

/* alterar algo */
alter table tb_Paciente

/* adicionando uma coluna */
add column Convenio_Paciente varchar(50);

/* adicionando uma atualização dentro de uma tabela */
update tb_Paciente
set Convenio_Paciente = 'Sirio Libanês'
where Nome_Paciente = 'Roberto Carlos';

/* exibir tudo das tabelas */
Select * from tb_Consulta as c 
/* juntando (unindo) a tabel consulta com a tabela paciente */
Join tb_Paciente as p 
/* onde a ligação será pelo Id das duas tabelas */
on c.id_Consulta = p.id_Paciente; 

/* os apelidos são registrados através da clausula AS que tb podem ser chamados de ALIAS */

/* exibir tudo das tabelas */
select c.Data_Consulta, p.Nome_Paciente from tb_Consulta as c
/* juntando (unindo) a tabel consulta com a tabela paciente */
Join tb_Paciente as p 
/* onde a ligação será pelo Id das duas tabelas */
on c.id_Consulta = p.id_Paciente;

/* usando o INNER JOIN */

select *  from tb_Consulta as c
join tb_Paciente as p
on c.id_Consulta = p.id_Paciente
join tb_Medico as m
on c.id_Consulta = m.id_Medico;

select c.Data_Consulta, p.Nome_Paciente, m.Nome_Medico  from tb_Consulta as c
join tb_Paciente as p
on c.id_Consulta = p.id_Paciente
join tb_Medico as m
on c.id_Consulta = m.id_Medico
order by p.Nome_Paciente; /* order by coloca em ordem alfabética */

delete from tb_Consulta
where fk_id_Medico = 1;