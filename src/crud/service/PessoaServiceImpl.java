package crud.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import crud.dao.PessoaDAO;
import crud.model.Pessoa;

@Service
@Transactional
public class PessoaServiceImpl implements PessoaService {

	private PessoaDAO pessoaDAO;

	public void setPessoaDAO(PessoaDAO pessoaDAO) {
		this.pessoaDAO = pessoaDAO;
	}

	
	@Override
	public void addPessoa(Pessoa p) {
		this.pessoaDAO.addPessoa(p);
		
	}

	@Override
	public void updatePessoa(Pessoa p) {
		this.pessoaDAO.updatePessoa(p);
		
	}

	@Override
	public List<Pessoa> listPessoas() { 
		return this.pessoaDAO.listPessoas();
	}

	@Override
	public Pessoa getPessoaById(int id) { 
		return this.pessoaDAO.getPessoaById(id);
	}

	@Override
	public void removePessoa(int id) {
		this.pessoaDAO.removePessoa(id);
		
	}

	@Override
	public void removeProduto(int id) {
		this.pessoaDAO.removeProduto(id);
		
	}
	
}
