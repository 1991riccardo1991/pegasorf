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
 * Home object for domain model class Nazionalita.
 * @see erreeffe.entity.Nazionalita
 * @author Hibernate Tools
 */
public class NazionalitaHome {

	private static final Log log = LogFactory.getLog(NazionalitaHome.class);

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

	public void persist(Nazionalita transientInstance) {
		log.debug("persisting Nazionalita instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(Nazionalita instance) {
		log.debug("attaching dirty Nazionalita instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Nazionalita instance) {
		log.debug("attaching clean Nazionalita instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(Nazionalita persistentInstance) {
		log.debug("deleting Nazionalita instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Nazionalita merge(Nazionalita detachedInstance) {
		log.debug("merging Nazionalita instance");
		try {
			Nazionalita result = (Nazionalita) sessionFactory
					.getCurrentSession().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public Nazionalita findById(long id) {
		log.debug("getting Nazionalita instance with id: " + id);
		try {
			Nazionalita instance = (Nazionalita) sessionFactory
					.getCurrentSession().get("erreeffe.entity.Nazionalita", id);
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

	public List<Nazionalita> findByExample(Nazionalita instance) {
		log.debug("finding Nazionalita instance by example");
		try {
			List<Nazionalita> results = (List<Nazionalita>) sessionFactory
					.getCurrentSession().createCriteria(
							"erreeffe.entity.Nazionalita")
					.add(create(instance)).list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
}
