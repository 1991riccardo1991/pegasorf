package it.infolabs.hibernate;
// Generated 26-ago-2009 22.04.12 by Hibernate Tools 3.2.5.Beta

import it.infolabs.hibernate.exception.FindAllEntityException;
import it.infolabs.hibernate.exception.FindByNotFoundException;

import java.util.ArrayList;
import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.hibernate.LockMode;
import org.hibernate.criterion.Example;

/**
 * Home object for domain model class Pannelli.
 * @see it.infolabs.hibernate.Pannelli
 * @author Hibernate Tools
 */
public class PannelliHome extends BusinessObjectHome {

	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(PannelliHome.class);

	private static final Log log = LogFactory.getLog(PannelliHome.class);

	private static final PannelliHome instance = new PannelliHome();

	private PannelliHome() {
		super();
	}

	public static PannelliHome getInstance() {
		return instance;
	}

	public void persist(Pannelli transientInstance) {
		log.debug("persisting Pannelli instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(Pannelli instance) {
		log.debug("attaching dirty Pannelli instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Pannelli instance) {
		log.debug("attaching clean Pannelli instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(Pannelli persistentInstance) {
		log.debug("deleting Pannelli instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Pannelli merge(Pannelli detachedInstance) {
		log.debug("merging Pannelli instance");
		try {
			Pannelli result = (Pannelli) sessionFactory.getCurrentSession()
					.merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public Pannelli findById(long id) throws FindByNotFoundException{
		log.debug("getting Pannelli instance with id: " + id);
		try {
			Pannelli instance = (Pannelli) sessionFactory.getCurrentSession()
					.get("it.infolabs.hibernate.Pannelli", id);
			if (instance == null) {
				log.debug("get successful, no instance found");
			} else {
				log.debug("get successful, instance found");
			}
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw new FindByNotFoundException();
		}
	}

	public List findByExample(Pannelli instance) {
		log.debug("finding Pannelli instance by example");
		try {
			List results = sessionFactory.getCurrentSession().createCriteria(
					"it.infolabs.hibernate.Pannelli").add(Example.create(instance))
					.list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
	
	/**
	 * Ritorna tutti i pannelli da visualizzare
	 * @return
	 */
	public ArrayList<Pannelli> allPannelli() throws FindAllEntityException{		
		log.debug("finding all Pannelli.");
		try {
			ArrayList<Pannelli> results = (ArrayList<Pannelli>) sessionFactory.
					getCurrentSession().createCriteria("it.infolabs.hibernate.Pannelli").list();
			
			log.debug("finding all Pannelli successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("finding all Pannelli failed", re);
			throw new FindAllEntityException();
		}
	}
}
