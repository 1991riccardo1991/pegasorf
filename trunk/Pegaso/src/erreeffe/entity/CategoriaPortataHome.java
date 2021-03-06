package erreeffe.entity;

// Generated 20-nov-2008 2.05.45 by Hibernate Tools 3.2.2.GA

import java.util.List;
import javax.naming.InitialContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.SessionFactory;
import static org.hibernate.criterion.Example.create;

/**
 * Home object for domain model class CategoriaPortata.
 * @see erreeffe.entity.CategoriaPortata
 * @author Hibernate Tools
 */
public class CategoriaPortataHome {

	private static final Log log = LogFactory
			.getLog(CategoriaPortataHome.class);

	private final SessionFactory sessionFactory = getSessionFactory();

	protected SessionFactory getSessionFactory() {
		try {
			return (SessionFactory) new InitialContext()
					.lookup("SessionFactory");
		} catch (Exception e) {
			log.error("Could not locate SessionFactory in JNDI", e);
			throw new IllegalStateException(
					"Could not locate SessionFactory in JNDI");
		}
	}

	public void persist(CategoriaPortata transientInstance) {
		log.debug("persisting CategoriaPortata instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(CategoriaPortata instance) {
		log.debug("attaching dirty CategoriaPortata instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(CategoriaPortata instance) {
		log.debug("attaching clean CategoriaPortata instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(CategoriaPortata persistentInstance) {
		log.debug("deleting CategoriaPortata instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public CategoriaPortata merge(CategoriaPortata detachedInstance) {
		log.debug("merging CategoriaPortata instance");
		try {
			CategoriaPortata result = (CategoriaPortata) sessionFactory
					.getCurrentSession().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public CategoriaPortata findById(long id) {
		log.debug("getting CategoriaPortata instance with id: " + id);
		try {
			CategoriaPortata instance = (CategoriaPortata) sessionFactory
					.getCurrentSession().get(
							"erreeffe.entity.CategoriaPortata", id);
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

	public List<CategoriaPortata> findByExample(CategoriaPortata instance) {
		log.debug("finding CategoriaPortata instance by example");
		try {
			List<CategoriaPortata> results = (List<CategoriaPortata>) sessionFactory
					.getCurrentSession().createCriteria(
							"erreeffe.entity.CategoriaPortata").add(
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
