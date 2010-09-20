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
 * Home object for domain model class Documento.
 * @see it.infolabs.hibernate.Documento
 * @author Hibernate Tools
 */
public class DocumentoHome extends BusinessObjectHome{
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(DocumentoHome.class);

	private static final DocumentoHome instance=new DocumentoHome();

	private DocumentoHome() {
		super();
	}

	public static DocumentoHome getInstance() {
		return instance;
	}

	public void persist(Documento transientInstance) {
		log.debug("persisting Documento instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(Documento instance) {
		log.debug("attaching dirty Documento instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Documento instance) {
		log.debug("attaching clean Documento instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(Documento persistentInstance) {
		log.debug("deleting Documento instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Documento merge(Documento detachedInstance) {
		log.debug("merging Documento instance");
		try {
			Documento result = (Documento) sessionFactory.getCurrentSession()
					.merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public Documento findById(long id) {
		log.debug("getting Documento instance with id: " + id);
		try {
			Documento instance = (Documento) sessionFactory.getCurrentSession()
					.get("it.infolabs.hibernate.Documento", id);
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

	public List<Documento> findByExample(Documento instance) {
		log.debug("finding Documento instance by example");
		try {
			List<Documento> results = (List<Documento>) sessionFactory
					.getCurrentSession().createCriteria(
							"it.infolabs.hibernate.Documento").add(
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
