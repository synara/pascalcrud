Program Pzim ;

const max = 100;

type
regAP = record
  nome : string[50];
  matricula : integer;
end;

type
regDisc = record
  codigo : integer;
  descricao : string[40];
end;


type
regTurma = record
  codTurma : integer;
  codProfessor : integer;
  codDisc : integer;
  codAluno : integer;
  vAluno : array[1..max] of integer;
end;

var
regAlunos : regAP;
regProfessores : regAP;
regDisciplinas : regDisc;
regTurmas : regTurma;
vetTurmas : array[1..max] of regTurma;
vetAlunos : array[1..max] of regAP;
vetProfessores : array[1..max] of regAP;
vetDisciplinas : array[1..max] of regDisc;
opcaoMenu, opcaoSubMenu : integer;
nAlunos, nProfessores, nDisciplinas, nTurmas, qtdalunos : integer;

Procedure Menu;
begin
  clrscr;
  textcolor(white);
  writeln('==============================');
  writeln('        MENU PRINCIPAL    ');
  writeln('==============================');
  writeln;
  writeln;
  textcolor(3);
  writeln('       ALUNOS     ');
  writeln('[1] Cadastrar alunos');
  writeln('[2] Remover alunos');
  writeln('[3] Alterar dados de alunos');
  writeln('[4] Listar alunos');
  textcolor(9);
  writeln;
  writeln('    PROFESSORES   ');
  writeln('[5] Cadastrar professores');
  writeln('[6] Remover professores');
  writeln('[7] Alterar dados de professores');
  writeln('[8] Listar professores');
  textcolor(8);
  writeln;
  writeln('    DISCIPLINAS   ');
  writeln('[9] Cadastrar disciplinas');
  writeln('[10] Remover disciplinas');
  writeln('[11] Alterar dados de disciplinas');
  writeln('[12] Listar disciplinas');
  textcolor(6);
  writeln;
  writeln('    TURMAS   ');
  writeln('[13] Cadastrar turmas');
  writeln('[14] Remover turmas');
  writeln('[15] Alterar dados de turmas');
  writeln('[16] Listar turmas');
  writeln;
  textcolor(white);
  writeln('[17] Fechar programa');
  writeln;
  writeln('Informe a opção desejada: ');
  
end;

Function BuscarAlunos(matr : integer) : integer;
var
posicao : integer;

begin
  for posicao := 1 to max do
  begin
    if vetAlunos[posicao].matricula = matr then
    begin
      BuscarAlunos := posicao;
      break;
    end;
  end;
  
  if posicao > max then
  begin
    //excedeu o tamanho do vetor
    BuscarAlunos := 0;
  end;
end;


Procedure InserirAlunos;
var
posicao : integer;
rst : char;

begin
  //nAlunos := 0;
  posicao := 1;
  repeat
    clrscr;
    repeat
      writeln('Informe a matrícula: ');
      readln(regAlunos.matricula);
      
      if regAlunos.matricula <= 0 then
      begin
        writeln('Matrícula inválida!');
      end;
    until regAlunos.matricula > 0;
    
    
    posicao := BuscarAlunos(regAlunos.matricula);
    
    if posicao > 0 then
    begin
      writeln('Matrícula já existe no sistema.');
    end else
    begin
      posicao := BuscarAlunos(0);
      if posicao = 0 then
      begin
        writeln('Cadastro não permitido. Limite esgotado.');
      end else
      begin
        writeln('Informe o nome do aluno: ');
        read(regAlunos.nome);
        
        vetAlunos[posicao] := regAlunos;
        posicao := posicao + 1;
        nAlunos := nAlunos + 1;
        writeln('Aluno inserido com sucesso!');
      end;
    end;
    writeln;
    writeln('Deseja incluir um novo aluno (S/N)?');
    readln(rst);
  until upcase(rst) = 'N';
  end;
  
  Procedure AlterarAlunos;
  var
  codigo, posicao : integer;
  rst : char;
  
  begin
    repeat
      clrscr;
      repeat
        write('Informe a matricula do aluno: ');
        read(codigo);
        
        if codigo <= 0 then
        begin
          writeln('Matricula inválida! Informe um código positivo.');
        end;
      until codigo > 0;
      
      posicao := BuscarAlunos(codigo);
      
      if posicao > 0 then
      begin
        write('Matricula: ', vetAlunos[posicao].matricula, '. Informe a nova matricula: ');
        read(vetAlunos[posicao].matricula);
        write('Nome: ', vetAlunos[posicao].nome, '. Informe o novo nome: ');
        read(vetAlunos[posicao].nome);
        writeln('Dados alterados com sucesso!');
      end else
      begin
        writeln('Código inexistente.');
      end;
      
      
      writeln('Deseja alterar dados de outros alunos? (S/N)?');
      readln(rst);
    until upcase(rst) = 'N';
      
    end;
    
    Procedure RemoverAlunos;
    var
    posicao, i : integer;
    rst : char;
    begin
      posicao := 1;
      repeat
        clrscr;
        repeat
          writeln('Informe a matrícula: ');
          readln(regAlunos.matricula);
          
          if regAlunos.matricula <= 0 then
          begin
            writeln('Matrícula inválida! Informe um número positivo.');
          end;
        until regAlunos.matricula > 0;
        
        
        posicao := BuscarAlunos(regAlunos.matricula);
        
        if posicao > 0 then
        begin
          for i:= 1 to nAlunos do
          begin
            vetAlunos[posicao].nome := vetAlunos[posicao+1].nome;
            vetAlunos[posicao].matricula := vetAlunos[posicao+1].matricula;
            posicao := posicao + 1;
          end;
          vetAlunos[posicao+1].nome := '';
          vetAlunos[posicao+1].matricula := 0;
          nAlunos := nAlunos - 1;
          writeln('Aluno removido com sucesso!');
        end else
        writeln('Matrícula não existe no sistema.');
        
        writeln('Deseja remover outro aluno (S/N)?');
        readln(rst);
      until upcase(rst) = 'N';
      end;
      
      
      Procedure ListarAlunos;
      var
      i : integer;
      opcao : char;
      begin
        repeat
          for i:= 1 to nAlunos do
          begin
            writeln('Aluno: ', vetAlunos[i].nome);
            writeln('Matrícula: ', vetAlunos[i].matricula);
            writeln;
          end;
          writeln('Deseja voltar ao menu (S)?');
          readln(opcao);
        until upcase(opcao) = 'S';
        end;
        
        Function BuscarProfessores(matr : integer) : integer;
        var
        posicao : integer;
        
        begin
          for posicao := 1 to max do
          begin
            if vetProfessores[posicao].matricula = matr then
            begin
              BuscarProfessores := posicao;
              break;
            end;
          end;
          
          if posicao > max then
          begin
            //excedeu o tamanho do vetor
            BuscarProfessores := 0;
          end;
        end;
        
        
        Procedure InserirProfessores;
        var
        posicao : integer;
        rst : char;
        
        begin
          //nProfessores := 0;
          posicao := 1;
          repeat
            clrscr;
            repeat
              writeln('Informe a matrícula: ');
              readln(regProfessores.matricula);
              
              if regProfessores.matricula <= 0 then
              begin
                writeln('Matrícula inválida!');
              end;
            until regProfessores.matricula > 0;
            
            
            posicao := BuscarProfessores(regProfessores.matricula);
            
            if posicao > 0 then
            begin
              writeln('Matrícula já existe no sistema.');
            end else
            begin
              posicao := BuscarProfessores(0);
              if posicao = 0 then
              begin
                writeln('Cadastro não permitido. Limite esgotado.');
              end else
              begin
                writeln('Informe o nome do professor: ');
                read(regProfessores.nome);
                
                vetProfessores[posicao] := regProfessores;
                posicao := posicao + 1;
                nProfessores := nProfessores + 1;
                writeln('Professor inserido com sucesso!');
              end;
            end;
            
            writeln('Deseja incluir um novo professor (S/N)?');
            readln(rst);
          until upcase(rst) = 'N';
          end;
          
          
          Procedure AlterarProfessores;
          var
          codigo, posicao : integer;
          rst : char;
          
          begin
            repeat
              clrscr;
              repeat
                write('Informe a matricula do aluno: ');
                read(codigo);
                
                if codigo <= 0 then
                begin
                  writeln('Matricula inválida! Informe um código positivo.');
                end;
              until codigo > 0;
              
              posicao := BuscarProfessores(codigo);
              
              if posicao > 0 then
              begin
                write('Matricula: ', vetProfessores[posicao].matricula, '. Informe a nova matricula: ');
                read(vetProfessores[posicao].matricula);
                write('Nome: ', vetProfessores[posicao].nome, '. Informe o novo nome: ');
                read(vetProfessores[posicao].nome);
                writeln('Dados alterados com sucesso!');
              end else
              begin
                writeln('Código inexistente.');
              end;
              
              
              writeln('Deseja alterar dados de outros professores? (S/N)?');
              readln(rst);
            until upcase(rst) = 'N';
              
            end;
            
            Procedure RemoverProfessores;
            var
            posicao, i : integer;
            rst : char;
            begin
              posicao := 1;
              repeat
                clrscr;
                repeat
                  writeln('Informe a matrícula: ');
                  readln(regProfessores.matricula);
                  
                  if regProfessores.matricula <= 0 then
                  begin
                    writeln('Matrícula inválida! Informe um número positivo.');
                  end;
                until regProfessores.matricula > 0;
                
                
                posicao := BuscarProfessores(regProfessores.matricula);
                
                if posicao > 0 then
                begin
                  for i:= 1 to nProfessores do
                  begin
                    vetProfessores[posicao].nome := vetProfessores[posicao+1].nome;
                    vetProfessores[posicao].matricula := vetProfessores[posicao+1].matricula;
                    posicao := posicao + 1;
                  end;
                  vetProfessores[posicao+1].nome := '';
                  vetProfessores[posicao+1].matricula := 0;
                  nProfessores := nProfessores - 1;
                  writeln('Professor removido com sucesso!');
                end else
                writeln('Matrícula não existe no sistema.');
                
                writeln('Deseja remover outro professor (S/N)?');
                readln(rst);
              until upcase(rst) = 'N';
              end;
              
              Procedure ListarProfessores;
              var
              i : integer;
              opcao : char;
              begin
                repeat
                  for i:= 1 to nProfessores do
                  begin
                    writeln('Professor: ', vetProfessores[i].nome);
                    writeln('Matrícula: ', vetProfessores[i].matricula);
                    writeln;
                  end;
                  writeln('Deseja voltar ao menu (S)?');
                  readln(opcao);
                until upcase(opcao) = 'S';
                end;
                
                Function BuscarDisciplinas(matr : integer) : integer;
                var
                posicao : integer;
                
                begin
                  for posicao := 1 to max do
                  begin
                    if vetDisciplinas[posicao].codigo = matr then
                    begin
                      BuscarDisciplinas := posicao;
                      break;
                    end;
                  end;
                  
                  if posicao > max then
                  begin
                    //excedeu o tamanho do vetor
                    BuscarDisciplinas := 0;
                  end;
                end;
                
                Procedure InserirDisciplinas;
                var
                posicao : integer;
                rst : char;
                
                begin
                  //nDisciplinas := 0;
                  posicao := 1;
                  repeat
                    clrscr;
                    repeat
                      writeln('Informe o código da disciplina: ');
                      readln(regDisciplinas.codigo);
                      
                      if regDisciplinas.codigo <= 0 then
                      begin
                        writeln('Código inválida!');
                      end;
                    until regDisciplinas.codigo > 0;
                    
                    
                    posicao := BuscarDisciplinas(regDisciplinas.codigo);
                    
                    if posicao > 0 then
                    begin
                      writeln('Código já existe no sistema.');
                    end else
                    begin
                      posicao := BuscarDisciplinas(0);
                      if posicao = 0 then
                      begin
                        writeln('Cadastro não permitido. Limite esgotado.');
                      end else
                      begin
                        writeln('Informe o nome da disciplina: ');
                        read(regDisciplinas.descricao);
                        
                        vetDisciplinas[posicao] := regDisciplinas;
                        posicao := posicao + 1;
                        nDisciplinas := nDisciplinas + 1;
                        writeln('Disciplina inserida com sucesso!');
                      end;
                    end;
                    
                    writeln('Deseja incluir uma nova disciplina (S/N)?');
                    readln(rst);
                  until upcase(rst) = 'N';
                  end;
                  
                  Procedure AlterarDisciplinas;
                  var
                  codigo, posicao : integer;
                  rst : char;
                  
                  begin
                    repeat
                      clrscr;
                      repeat
                        write('Informe o código da disciplina: ');
                        read(codigo);
                        
                        if codigo <= 0 then
                        begin
                          writeln('Código inválido! Informe um código positivo.');
                        end;
                      until codigo > 0;
                      
                      posicao := BuscarDisciplinas(codigo);
                      
                      if posicao > 0 then
                      begin
                        write('Código: ', vetDisciplinas[posicao].codigo, '. Informe o novo código: ');
                        read(vetDisciplinas[posicao].codigo);
                        write('Nome: ', vetDisciplinas[posicao].descricao, '. Informe o novo nome: ');
                        read(vetDisciplinas[posicao].descricao);
                        writeln('Dados alterados com sucesso!');
                      end else
                      begin
                        writeln('Código inexistente.');
                      end;
                      
                      
                      writeln('Deseja alterar dados de outras disciplinas? (S/N)?');
                      readln(rst);
                    until upcase(rst) = 'N';
                      
                    end;
                    
                    Procedure RemoverDisciplinas;
                    var
                    posicao, i : integer;
                    rst : char;
                    begin
                      posicao := 1;
                      repeat
                        clrscr;
                        repeat
                          writeln('Informe o código da disciplina: ');
                          readln(regDisciplinas.codigo);
                          
                          if regDisciplinas.codigo <= 0 then
                          begin
                            writeln('Código inválido! Informe um código positivo.');
                          end;
                        until regDisciplinas.codigo > 0;
                        
                        
                        posicao := BuscarDisciplinas(regDisciplinas.codigo);
                        
                        if posicao > 0 then
                        begin
                          for i:=1 to nDisciplinas do
                          begin
                            vetDisciplinas[posicao].descricao := vetDisciplinas[posicao+1].descricao;
                            vetDisciplinas[posicao].codigo := vetDisciplinas[posicao+1].codigo;
                            posicao := posicao + 1;
                          end;
                          vetDisciplinas[posicao+1].descricao := '';
                          vetDisciplinas[posicao+1].codigo := 0;
                          nDisciplinas := nDisciplinas - 1;
                          writeln('Disciplina removida com sucesso!');
                        end else
                        writeln('Código não existe no sistema.');
                        
                        writeln('Deseja remover outra disciplina(S/N)?');
                        readln(rst);
                      until upcase(rst) = 'N';
                      end;
                      
                      Procedure ListarDisciplinas;
                      var
                      i : integer;
                      opcao : char;
                      begin
                        repeat
                          for i:= 1 to nDisciplinas do
                          begin
                            writeln('Disciplina: ', vetDisciplinas[i].descricao);
                            writeln('Código: ', vetDisciplinas[i].codigo);
                            writeln;
                          end;
                          writeln('Deseja voltar ao menu (S)?');
                          readln(opcao);
                        until upcase(opcao) = 'S';
                        end;
                        
                        
                        Function BuscarTurmas(codigo : integer) : integer;
                        var
                        posicao : integer;
                        
                        begin
                          for posicao := 1 to max do
                          begin
                            if vetTurmas[posicao].codTurma = codigo then
                            begin
                              BuscarTurmas := posicao;
                              break;
                            end;
                          end;
                          
                          if posicao > max then
                          begin
                            //excedeu o tamanho do vetor
                            BuscarTurmas := 0;
                          end;
                        end;
                        
                        
                        Procedure InserirTurmas;
                        var
                        posicao, posicaoProf, posicaoDisc, posicaoAluno, i : integer;
                        rst : char;
                        
                        begin
                          //nTurmas := 0;
                          posicao := 1;
                          i := 1;
                          
                          repeat
                            clrscr;
                            repeat
                              writeln('Informe o código da turma: ');
                              readln(regTurmas.codTurma);
                              
                              if regTurmas.codTurma <= 0 then
                              begin
                                writeln('Código inválido!');
                              end;
                            until regTurmas.codTurma > 0;
                            
                            posicao := BuscarTurmas(regTurmas.codTurma);
                            
                            if posicao > 0 then
                            begin
                              writeln('Código já existe no sistema.');
                              
                            end else
                            posicao := BuscarTurmas(0);
                            if posicao = 0 then
                            begin
                              writeln('Cadastro não permitido. Limite esgotado.');
                              
                            end else
                            writeln('Informe o código do professor: ');
                            read(regTurmas.codProfessor);
                            
                            posicaoProf := BuscarProfessores(regTurmas.codProfessor);
                            
                            if posicaoProf <= 0 then
                            begin
                              writeln('Código do professor não existe no sistema.');
                              break;
                            end else
                            writeln('Informe o código da disciplina: ');
                            read(regTurmas.codDisc);
                            
                            posicaoDisc := BuscarDisciplinas(regTurmas.codDisc);
                            
                            if posicaoDisc <= 0 then
                            begin
                              writeln('Código de disciplina não existe no sistema.');
                              break;
                            end else
                            writeln('Podem ser matriculados até 50 alunos nessa turma.');
                            writeln;
                            writeln('Quantos alunos deseja inserir?');
                            read(qtdalunos);
                            
                            for i := 1 to qtdalunos do
                            begin
                              writeln('Informe a matrícula do aluno: ');
                              read(regTurmas.codAluno);
                              
                              posicaoAluno := BuscarAlunos(regTurmas.codAluno);
                              
                              if posicaoAluno <= 0 then
                              begin
                                writeln('Matrícula não existe no sistema.');
                                break;
                              end else
                              regTurmas.vAluno[posicaoAluno] := regTurmas.codAluno;
                            end;
                            
                            vetTurmas[posicao] := regTurmas;
                            posicao := posicao + 1;
                            nTurmas := nTurmas + 1;
                            
                            
                            writeln('Deseja inserir nova turma (S/N)?');
                            read(rst);
                          until upcase(rst) = 'N';
                            
                          end;
                          
                          Procedure AlterarTurmas;
                          var
                          codigo, posicao, opcao, cprof, posprof, cdisc, posdisc, caluno, posmatr, posicaoAluno, novaMatricula : integer;
                          
                          begin
                            writeln('Informe o código da turma que deseja alterar: ');
                            read(codigo);
                            
                            posicao := BuscarTurmas(codigo);
                            
                            if posicao > 0 then
                            begin
                              writeln('O que desejas alterar?');
                              writeln('1. Professor 2. Disciplina 3. Aluno(s)');
                              read(opcao);
                              
                              case opcao of
                                1: begin
                                  writeln('Informe o novo código do professor: ');
                                  read(cprof);
                                  
                                  posprof := BuscarProfessores(cprof);
                                  
                                  if posprof > 0 then
                                  begin
                                    vetTurmas[posicao].codProfessor := cprof;
                                  end else
                                  begin
                                    writeln('Novo código de professor não existe no sistema.');
                                  end;
                                  
                                end;
                                
                                2: begin
                                  writeln('Informe o novo código da disciplina: ');
                                  read(cdisc);
                                  
                                  posdisc := BuscarDisciplinas(cdisc);
                                  
                                  if posdisc > 0 then
                                  begin
                                    vetTurmas[posicao].codDisc := cdisc;
                                  end else
                                  begin
                                    writeln('Novo código de disciplina não existe no sistema.');
                                  end;
                                end;
                                
                                3: begin
                                  writeln('Matrícula do aluno que deseja alterar: ');
                                  read(caluno);
                                  
                                  posicaoAluno := BuscarAlunos(vetTurmas[posicao].vAluno[caluno]);
                                  
                                  if posicaoAluno > 0 then
                                  begin
                                    writeln('Informe a nova matrícula: ');
                                    read(novaMatricula);
                                    
                                    posmatr := BuscarAlunos(novaMatricula);
                                    
                                    if posmatr > 0 then
                                    begin
                                      vetTurmas[posicao].vAluno[posicaoAluno] := novaMatricula;
                                    end else
                                    begin
                                      writeln('Novo código do aluno não existe no sistema.');
                                    end;
                                    
                                  end;
                                end;
                                
                                
                              end;
                            end;
                          end;
                          
                          Procedure RemoverTurmas;
                          var
                          posicao, codigo, v : integer;
                          
                          begin
                            clrscr;
                            writeln('Informe o código da turma: ');
                            read(codigo);
                            
                            posicao := BuscarTurmas(codigo);
                            
                            if posicao > 0 then
                            begin
                              vetTurmas[posicao].codTurma := 0;
                              vetTurmas[posicao].codProfessor := 0;
                              vetTurmas[posicao].codDisc := 0;
                              for v:=1 to max do
                              begin
                                vetTurmas[posicao].vAluno[v] := 0;
                              end;
                              nTurmas := nTurmas - 1;
                              writeln('Turma removida com sucesso!');
                            end;
                          end;
                          
                          Procedure ListarTurmas;
                          var
                          i, v : integer;
                          opcao : char;
                          begin
                            repeat
                              for i:= 1 to nTurmas do
                              begin
                                writeln('Código da turma: ', vetTurmas[i].codTurma);
                                writeln('Código do professor: ', vetTurmas[i].codProfessor);
                                writeln('Código da disciplina: ', vetTurmas[i].codDisc);
                                writeln('Alunos: ');
                                for v:=1 to qtdalunos do
                                begin
                                  writeln('Matrícula do aluno: ', vetTurmas[i].vAluno[v],'.');
                                end;
                                writeln;
                              end;
                              writeln('Deseja voltar ao menu (S)?');
                              readln(opcao);
                            until upcase(opcao) = 'S';
                            end;
                            
                            
                            
                            Begin
                              repeat
                                Menu;
                                read(opcaoMenu);
                                
                                clrscr;
                                case opcaoMenu of
                                  1: InserirAlunos;
                                  2: RemoverAlunos;
                                  3: AlterarAlunos;
                                  4: ListarAlunos;
                                  5: InserirProfessores;
                                  6: RemoverProfessores;
                                  7: AlterarProfessores;
                                  8: ListarProfessores;
                                  9: InserirDisciplinas;
                                  10: RemoverDisciplinas;
                                  11: AlterarDisciplinas;
                                  12: ListarDisciplinas;
                                  13: InserirTurmas;
                                  14: RemoverTurmas;
                                  15: AlterarTurmas;
                                  16: ListarTurmas;
                                  17: exit();
                                end;
                                
                              until opcaoSubMenu = 17;
                            End.