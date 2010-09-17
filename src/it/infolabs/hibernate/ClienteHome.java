package it.infolabs.hibernate;

// Generated 1-feb-2010 0.56.14 by Hibernate Tools 3.2.4.GA

import it.infolabs.hibernate.exception.FindAllEntityException;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.LockMode;
import org.hibernate.criterion.Order;

import rf.utility.db.DBManager;

import static org.hibernate.criterion.Example.create;

/**
 * Home object for domain model class Cliente.
 * @see it.infolabs.hibernate.Cliente
 * @author Hibernate Tools
 */
public class ClienteHome extends BusinessObjectHome{
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(AspettoHome.class);

	private static final ClienteHome instance=new ClienteHome();

	private ClienteHome() {
		super();
	}

	public static ClienteHome getInstance() {
		return instance;
	}

	public void persist(Cliente transientInstance) {
		log.debug("persisting Cliente instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(Cliente instance) {
		log.debug("attaching dirty Cliente instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Cliente instance) {
		log.debug("attaching clean Cliente instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(Cliente persistentInstance) {
		log.debug("deleting Cliente instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Cliente merge(Cliente detachedInstance) {
		log.debug("merging Cliente instance");
		try {
			Cliente result = (Cliente) sessionFactory.getCurrentSession()
					.merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public Cliente findById(long id) {
		log.debug("getting Cliente instance with id: " + id);
		try {
			Cliente instance = (Cliente) sessionFactory.getCurrentSession()
					.get("it.infolabs.hibernate.Cliente", id);
			if (instance == null) {
				log.debug("get successful, no instance found");
			} else {
				log.debug("get successful, instance found");
			}
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List<Cliente> findByExample(Cliente instance) {
		log.debug("finding Cliente instance by example");
		try {
			List<Cliente> results = (List<Cliente>) sessionFactory
					.getCurrentSession().createCriteria(
							"it.infolabs.hibernate.Cliente").add(
							create(instance)).list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
	
	public List<Cliente> findAll() throws FindAllEntityException {
		log.debug("finding All Cliente instance");
		try {
			List<Cliente> results = (List<Cliente>) sessionFactory
					.getCurrentSession().createCriteria(
							"it.infolabs.hibernate.Cliente").addOrder(Order.asc("cognome")).list();
			log.debug("find All Cliente successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find All Cliente failed", re);
			throw re;
		}
	}

	public String[] allClienti() throws SQLException {
		String[] o = null;
		ResultSet rs = null;
		Statement pst = null;
		String query = "select idcliente || ' - ' || cognome || ' ' || nome from cliente order by cognome,nome";
		pst = DBManager.getIstanceSingleton().getNewStatement();
		rs = pst.executeQuery(query);
		rs.last();
		o = new String[rs.getRow()];
		rs.beforeFirst();
		int pos = 0;
		while (rs.next()) {
			o[pos] = rs.getString(1);
			pos++;
		}
		if (pst != null)
			pst.close();
		if (rs != null)
			rs.close();
		return o;
	}
}
