package crud.dao;

import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import crud.model.Pessoa;
import crud.model.Produto;

@Repository
public class PessoaDAOImpl implements PessoaDAO {

	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sf) {
		this.sessionFactory = sf;
	}

	@Override
	public void addPessoa(Pessoa p) {
		Session session = this.sessionFactory.getCurrentSession();

		for (Produto prod : p.getProdutos()) {
			prod.setId(selectSequenceProduto());
		}

		p.setId(selectSequencePessoa());
		session.persist(p);

	}

	private Integer selectSequencePessoa() {
		Session session = this.sessionFactory.getCurrentSession();
		SQLQuery q = session.createSQLQuery("select pessoa_crud_seq.nextval from dual");
		return ((Number) q.uniqueResult()).intValue();
	}

	private Integer selectSequenceProduto() {
		Session session = this.sessionFactory.getCurrentSession();
		SQLQuery q = session.createSQLQuery("select produto_crud_seq.nextval from dual");
		return ((Number) q.uniqueResult()).intValue();
	}

	@Override
	public void updatePessoa(Pessoa p) {
		Session session = this.sessionFactory.getCurrentSession();
		
		for (Produto prod : p.getProdutos()) {
			if(prod.getId()==null){
				prod.setId(selectSequenceProduto());
			}
		}
		
		session.update(p);

	}

	@Override
	public List<Pessoa> listPessoas() {
		Session session = this.sessionFactory.getCurrentSession();
		List<Pessoa> personsList = session.createQuery("select distinct p from Pessoa p inner join fetch p.produtos as produtos")
				.list();

		return personsList;
	}

	@Override
	public Pessoa getPessoaById(int id) {
		Session session = this.sessionFactory.getCurrentSession();

		Pessoa p = (Pessoa) session
				.createQuery("select distinct p from Pessoa p inner join fetch p.produtos as produtos where p.id = :id")
				.setParameter("id", id).uniqueResult();

		return p;
	}

	@Override
	public void removePessoa(int id) {
		Session session = this.sessionFactory.getCurrentSession();
		Pessoa p = (Pessoa) getPessoaById(id);
		if (null != p) {
			session.delete(p);
		}

	}
	
	@Override
	public void removeProduto(int id) {
		Session session = this.sessionFactory.getCurrentSession();
		Produto p = (Produto) session.load(Produto.class, new Integer(id));
		if (null != p) {
			session.delete(p);
		}

	}
	
		
	
}
