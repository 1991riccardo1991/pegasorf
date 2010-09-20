package it.infolabs.hibernate;

// Generated 6-mag-2010 0.12.01 by Hibernate Tools 3.2.4.GA

import java.util.List;
import javax.naming.InitialContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.hibernate.LockMode;
import org.hibernate.SessionFactory;
import static org.hibernate.criterion.Example.create;

/**
 * Home object for domain model class Fattura.
 * @see it.infolabs.hibernate.Fattura
 * @author Hibernate Tools
 */
public class FatturaHome extends BusinessObjectHome{
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(FatturaHome.class);

	private static final FatturaHome instance=new FatturaHome();

	private FatturaHome() {
		super();
	}

	public static FatturaHome getInstance() {
		return instance;
	}
	
	
	public void persist(Fattura transientInstance) {
		log.debug("persisting Fattura instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(Fattura instance) {
		log.debug("attaching dirty Fattura instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Fattura instance) {
		log.debug("attaching clean Fattura instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(Fattura persistentInstance) {
		log.debug("deleting Fattura instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Fattura merge(Fattura detachedInstance) {
		log.debug("merging Fattura instance");
		try {
			Fattura result = (Fattura) sessionFactory.getCurrentSession()
					.merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public Fattura findById(long id) {
		log.debug("getting Fattura instance with id: " + id);
		try {
			Fattura instance = (Fattura) sessionFactory.getCurrentSession()
					.get("it.infolabs.hibernate.Fattura", id);
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

	public List<Fattura> findByExample(Fattura instance) {
		log.debug("finding Fattura instance by example");
		try {
			List<Fattura> results = (List<Fattura>) sessionFactory
					.getCurrentSession().createCriteria(
							"it.infolabs.hibernate.Fattura").add(
							create(instance)).list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
}
