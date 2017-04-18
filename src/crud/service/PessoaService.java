package crud.service;
import java.util.List;

import crud.model.Pessoa;

public interface PessoaService {

	public void addPessoa(Pessoa p);
	public void updatePessoa(Pessoa p);
	public List<Pessoa> listPessoas();
	public Pessoa getPessoaById(int id);
	public void removePessoa(int id);
	public void removeProduto(int id);
}
